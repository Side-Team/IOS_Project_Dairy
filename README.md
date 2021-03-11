# Ssdam(Stroke)


Stroke the mood of the day
> Life is good :smile:   
> But, Sometimes bad  
> So.. Come here when you're lonely  
> We'll Stroke(ssdam) your felling  

     
<details>
    <summary>Table of Contents</summary>

[1.Demo video](#demo-video)    
[2.Logo](#logo)    
[3.Version](#version)    
[4.Folder](#folder)  
[5.Reference](#reference)  
[6.개인정보 처리방침](#개인정보 처리방침)  


</details>
    
@copyright : MInwoo Lee, Semi Park, Boram Kim, Mingyu Yoo
    
## Demo video

## Logo
<img src="https://user-images.githubusercontent.com/46651965/108586872-58606b00-7394-11eb-87db-a2efb79a1680.png" width="30%">

# Version
### Swift version
- Swift 5

### Xcode Version
- 12.4


## Add Library

```swift
# For Library import

# For Use a calendar
pod 'FSCalendar'
```

---

# How to add CocoaPods to your project

## Adding CocoaPods to our project at Terminal

```swift
sudo gem install cocoapods
```

## Create a new Project

```swift
# Set folder path
cd ~/Desktop/Paraphrase

# Create Podfile
pod init   
# touch pod = Empty folder
```

## Called Podfile

```swift

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Paraphrase' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Paraphrase
	pod 'Library'
end
```

## At the terminal

```swift
# Create folder Pods, Kanna_07.xcworkspace, Podfile.lock 
pod install     
```
--- 
# Folder
### Image
![image](https://user-images.githubusercontent.com/46651965/108167033-6d40c280-7138-11eb-81f4-b693d868488b.png)

### Supporting Files

#### Images = Image File
- PNG

#### StoryBoard

#### Assets
- Assets.xcassets

### Source

#### Models = Data
#### VCs = View Controller's

# Reference
### 앱스토어 등록 방법
https://ithub.tistory.com/95

### Xcode → App store 빌드 방법
https://sansanji.tistory.com/entry/Xcode에서-앱스토어-등록-배포-하기

# 개인정보 처리방침
1. 개인정보의 처리 목적 <쓰담>(‘https://github.com/Side-Team/IOS_Project_Dairy’이하 ‘쓰담’) 은(는) 다음의 목적을 위하여 개인정보를 처리하고 있으며, 다음의 목적 이외의 용도로는 이용하지 않습니다.  
- 고객 가입의사 확인, 고객에 대한 서비스 제공에 따른 본인 식별.인증, 회원자격 유지.관리, 물품 또는 서비스 공급에 따른 금액 결제, 물품 또는 서비스의 공급.배송 등  


2. 개인정보의 처리 및 보유 기간  

① <쓰담>(‘https://github.com/Side-Team/IOS_Project_Dairy’이하 ‘쓰담’) 은(는) 정보주체로부터 개인정보를 수집할 때 동의 받은 개인정보 보유․이용기간 또는 법령에 따른 개인정보 보유․이용기간 내에서 개인  정보를 처리․보유합니다.  
  
② 구체적인 개인정보 처리 및 보유 기간은 다음과 같습니다.  
☞ 아래 예시를 참고하여 개인정보 처리업무와 개인정보 처리업무에 대한 보유기간 및 관련 법령, 근거 등을 기재합니다.  
(예시)- 고객 가입 및 관리 : 서비스 이용계약 또는 회원가입 해지시까지, 다만 채권․채무관계 잔존시에는 해당 채권․채무관계 정산시까지  
- 전자상거래에서의 계약․청약철회, 대금결제, 재화 등 공급기록 : 5년  
  
  
3. 정보주체와 법정대리인의 권리·의무 및 그 행사방법 이용자는 개인정보주체로써 다음과 같은 권리를 행사할 수 있습니다.  
  
① 정보주체는 쓰담(‘https://github.com/Side-Team/IOS_Project_Dairy’이하 ‘쓰담) 에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.  
1. 개인정보 열람요구  
2. 오류 등이 있을 경우 정정 요구  
3. 삭제요구  
4. 처리정지 요구  
  
  
  
4. 처리하는 개인정보의 항목 작성  
  
① <쓰담>('https://github.com/Side-Team/IOS_Project_Dairy'이하 '쓰담')은(는) 다음의 개인정보 항목을 처리하고 있습니다.  
  
1  
- 필수항목 : 이메일(로그인ID), 비밀번호  
- 선택항목 : 휴대폰번호, 이름  




5. 개인정보의 파기<쓰담>('쓰담')은(는) 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.  

-파기절차  
이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고  서는 다른 목적으로 이용되지 않습니다.  
  
-파기기한  
이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불  필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다.  
  

  
6. 개인정보 자동 수집 장치의 설치•운영 및 거부에 관한 사항  
  
① 쓰담 은 개별적인 맞춤서비스를 제공하기 위해 이용정보를 저장하고 수시로 불러오는 ‘쿠기(cookie)’를 사용합니다. ② 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용자의 컴퓨터 브라우저에게 보내는 소량의 정보이며 이용자들의 PC 컴퓨터내의 하드디스크에 저장되기도 합니다. 가. 쿠키의 사용 목적 : 이용자가 방문한 각 서비스와 웹 사이트들에 대한 방문 및 이용형태, 인기 검색어, 보안접속 여부, 등을 파악하여 이용자에게 최적화된 정보 제공을 위해 사용됩니다. 나. 쿠키의 설치•운영 및 거부 : 웹브라우저 상단의 도구>인터넷 옵션>개인정보 메뉴의 옵션 설정을 통해 쿠키 저장을 거부 할 수 있습니다. 다. 쿠키 저장을 거부할 경우 맞춤형 서비스 이용에 어려움이 발생할 수 있습니다.  


7. 개인정보 보호책임자 작성  


① 쓰담(‘https://github.com/Side-Team/IOS_Project_Dairy’이하 ‘쓰담) 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.  

▶ 개인정보 보호책임자  
성명 :유민규  
연락처 :01086730811, mg6613@naver.com  



8. 개인정보 처리방침 변경  

①이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.  



9. 개인정보의 안전성 확보 조치 <쓰담>('쓰담')은(는) 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.  

1. 정기적인 자체 감사 실시  
개인정보 취급 관련 안정성 확보를 위해 정기적(분기 1회)으로 자체 감사를 실시하고 있습니다.  

2. 내부관리계획의 수립 및 시행  
개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.  

3. 개인정보의 암호화  
이용자의 개인정보는 비밀번호는 암호화 되어 저장 및 관리되고 있어, 본인만이 알 수 있으며 중요한 데이터는 파일 및 전송 데이터를 암호화 하거나 파일 잠금 기능을 사용하는 등의 별도 보안기능을 사용하고 있습니다.  

4. 접속기록의 보관 및 위변조 방지  
개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.  

5. 개인정보에 대한 접근 제한  
개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.  
---
# 2021.03.04 "Review"
#### The name of the app in the App Store and the name of the downloaded app are different.  
### How to solve it
=> Change the display name of the app to ‘쓰담’

# 2021.03.05 " Ready for Sale, Version 1.0"  
#### The following app has been approved for the App Store:  
App Name: 쓰담  
App Version Number: 1.0  
App Type: iOS  

# 2021.03.11 "Solve issue & Add function"
## Solve issue
#### 1. Solving the problem of having two articles registered on a single day

## Add function
#### 1. Register an email to receive the required authentication number when clearing a password
- Enter the email to receive the authentication number when registering the password
- You can change your email address through the '이메일 변경' button in the upper right corner.

#### 2. Clear password
- If the password is incorrect 5 times, you can clear the password through email authentication.
- You can authenticate your email up to three times a day.
- If the authentication is successful, the password will clear and the password function will be turned off.

#### 3. When you change your email address or password
- When you change your email address or password, you must enter your existing password.

