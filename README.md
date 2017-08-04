<div dir="rtl">
پدیکا یک اسکریپت برای تقسیم کردن کردن صفحه‌های فایل های پی دی اف به چند قسمت و صفحه بندی مجدد آن‌هاست
</div>


## dependencies
libpng 16  
zlib1g  
ghost script  


## install dependencies
### debian bases
``` bash
sudo apt install libpng-dev
sudo apt install zlib1g-dev
```
### mac
``` bash
brew install libpng
xcode-select --install
brew install zlib
```


## install

<div dir="rtl">

بعد از دانلود کردن یا clone کردن این مخزن:  

<div dir="ltr">

```
perl Makefile.PL
make
make install
```

یا

```
cpanm https://github.com/kiamazi/pedika.git
```

</div>

### کاربرد
حتما پیش آمده با فایل‌های پی دی اف‌ اسکن شده از روی کتاب‌ها مواجه شده باشید که در هر صفحه از فایل پی دی اف، دو صفحه کتاب به صورت عرضی وجود داشته باشد.  

<div dir="ltr">

┌─┬─┐  
│2│1│  
└─┴─┘  

</div>

این اسکریپت، هر صفحه را به دو صفحه مجزا تقسیم میکند و پشت سر هم میچیند

<div dir="ltr">

┌─┐  
│1│  
├─┤  
│2│  
└─┘  

</div>

### نحوه استفاده

<div dir="ltr">

```
pedika -pdf source/file.pdf -save target/file/name.pdf -dpi 150 -dir rtl
```

</div>

<div dir="ltr">-pdf:</div>  
تنها سوییچ اجباری است که با آن آدرس و نام فایلی که میخواهید تقسیم شود را مشخص میکنید

<div dir="ltr">-save:</div>  
در صورتی که نام فایل جدیدی که میخواهیدرا وارد نکنید، نام فایل جدید برابر نام فایل قبل با اندیس پدیکا خواهد بود  

<div dir="ltr">

> target file name = source/file-pedika.pdf

</div>

<div dir="ltr">-dpi:</div>  
اگر رزولیشین را مشخص نکنید، مقدار ۱۵۰ به عنوان پیش فرض انتخاب میشود.  
هر چه عدد بزرگتری مشخص کنید، کیفیت بیشتری به دست میآید، اما سرعت انجام کار کمتر خواهد شد.

<div dir="ltr">-dir:</div>  
مشخص کننده‌ی اینکه صفحات از راست به چپ چیده شده اند یا از چپ به راست.  
اگر مقداری به آن داده نشود، صفحات راست به چپ در نظر گرفته میشوند.  
مقادیر مجاز:
<div dir="ltr">

 - rtl راست به چپ  
 - ltr چب به راست

 </div>  

</div>
