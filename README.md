# 📋 나의 메모


## 프로젝트 개요

#### 메모를 관리하는 앱입니다.
#### 나의 메모앱은 사용자의 메모를 추가, 편집, 삭제하고 완료된 메모를 확인할 수 있는 기능을 제공합니다.
#### 이 앱은 MemoManager클래스와 뷰 컨트롤러(MainViewController, MemoListViewController, DetailViewController, CompleteViewController)로 구성되어 있습니다.
#### 각 뷰 컨트롤러는 사용자 인터페이스를 구성하고 필요한 기능을 구현합니다.


<br><br>
- - -
## 🛠️ 사용한 기술 스택 (Tech Stack)
<img src="https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=Swift&logoColor=white"><img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white"><img src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">
- - -

<br><br>
- - -
## 🗓️ 개발 기간
* 2023-07-31(월) ~ 2023-08-10(목), 9일간
- - -
<br><br>

## 📌 주요 기능

### 1. MemoManager

#### MemoManager 클래스는 메모와 관련된 데이터와 동작을 관리하는 중요한 역할을 합니다. 이 클래스는 다음과 같은 기능을 제공합니다:

- 메모의 추가, 편집, 삭제 기능
- 메모의 완료 상태를 변경하는 기능
- 메모 목록과 완료된 메모 목록을 관리
- UserDefaults를 이용한 데이터 저장 및 로드

### 2. MainViewController

#### MainViewController는 메모 앱의 메인 화면을 구성하는 역할을 합니다. 다음과 같은 기능을 수행합니다:

- 이미지 뷰와 버튼을 UI에 추가하는 기능
- UI 요소를 설정하는 makeUI 메서드

### 3. MemoListViewController

#### MemoListViewController는 메모 목록을 보여주는 역할을 합니다. 이 컨트롤러는 다음과 같은 기능을 수행합니다:

- 메모 목록을 테이블 뷰로 표시
- 메모 추가, 삭제, 검색 기능 구현
- 스위치 상태에 따라 메모를 완료 상태로 표시하는 기능

### 4. DetailViewController

#### DetailViewController는 메모의 상세 내용을 보여주고 편집하는 역할을 합니다. 다음과 같은 기능을 수행합니다:

- 메모 내용을 텍스트 뷰로 표시
- 텍스트 뷰에서 메모 내용을 편집하고 돌아오면 자동으로 저장하는 기능

### 5. CompleteViewController

#### CompleteViewController는 완료된 메모를 보여주는 역할을 합니다. 이 뷰 컨트롤러는 다음과 같은 기능을 수행합니다:

- 완료된 메모 목록을 테이블 뷰로 표시
- 검색 기능을 통해 원하는 메모를 찾을 수 있는 기능


- - -

## 💥 미완성된 기능

### 검색중인 상태일때 메모리스트 편집
#### 🚨 확인된 오류

- 검색중인 상태에서 메모를 삭제시 메모의 인덱스를 벗어나며 앱이 종료되는 문제
- 검색중인 상태에서 메모의 완료여부 체크시 취소선이 그어지는 텍스트 스타일변경이 일어나지 않는 문제

