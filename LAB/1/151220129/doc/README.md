# 作业一 直方图均衡化
## 吴政亿 151220129 18805156360@163.com tel:18805156360 
*(南京大学 计算机科学与技术系, 南京  210093)*
### 实现细节

#### 单通道直方图均衡化
```matlab
function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    input_channel=im2double(input_channel);

    [M,N]=size(input_channel);
    [counts,x]=imhist(input_channel);
    location=find(counts~=0);
    MinCDF=min(counts(location));
    for j=1:length(location)
        CDF=sum(counts(location(1:j)));
        P=input_channel==x(location(j));
        input_channel(P)=(CDF-MinCDF)/(M*N-MinCDF);
%             input_channel(P) = CDF/(M*N);
    end
    [output2] = input_channel;
end
```
1. 先将其转化为double类型
2. 得到像素的大小为M*N
3. 统计灰度值x有多少个count
4. location得到灰度值个数不为0的x的下标
5. 得到location中最小值为MinCDF
6. 计算各个灰度级在直方图均衡化后的灰度级并修改

**优化**: 相比老师之间给出的公式
`input_channel(P) = CDF/(M*N);`   
进一步优化为
`input_channel(P)=(CDF-MinCDF)/(M*N-MinCDF)`，   
可以优化图像对比度不会因为最小值而过高

#### RGB图像直方图均衡化

##### 方法一 HSI图像
直接获得r,v,b三个通道，并对他们各自进行单通道直方图均衡化，   
然后再将他们拼合成RGB图像。发现效果非常的差，会产生严重的失真。

##### 方法二 HSI图像
将RGB图像转换为HSI图像，然后单独对I通道进行处理，效果与预计有偏差。   
在了解中，HSI优化效果与HSV应该是差不多的，但是在实验中产生了图片的破碎感，   
具体体现为：部分区域没有优化，从而与优化后的区域产生鲜明的对比。   
怀疑是hsi2rgb与rgb2hsi的实现有bug。

##### 方法三 HSV图像
将RGB图像转换为HSV图像，然后单独对V通道进行处理，发现效果非常好。
```matlab
    function [output4] = hist_HSV_equal(input_HSV_image)
        hv=rgb2hsv(input_HSV_image); 
        % 可以通过下面的程序看一幅图的HSV三个通道 
        H=hv(:,:,1);
        S=hv(:,:,2);
        V=hv(:,:,3);
        V1 = hist_equal(V);
        output4 = cat(3,H,S,V1);
        output4 = hsv2rgb(output4);
    end
```


### 结果

#### 实验设置
matlab window10环境，工作目录为code下。
#### 实验结果

##### 课上讲的直方图均衡化
![gray1](https://img-blog.csdn.net/2018040213380696?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RpY2Uw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

##### 优化后的直方图均衡化
![gray2](https://img-blog.csdn.net/20180402133822325?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RpY2Uw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

##### 对RGB三通道分别处理<方法一>
![rgb](https://img-blog.csdn.net/20180402133834681?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RpY2Uw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

##### 将RGB转化为HSI并处理I通道<方法二>
![hsi](https://img-blog.csdn.net/20180402133848154?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RpY2Uw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

##### 将RGB转化为HSV并处理V通道<方法三>
![hsv](https://img-blog.csdn.net/20180402133858721?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2p1c3RpY2Uw/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

