# 바다만봐도조아
## 앱소개
    - 제주도 바다에 대해서 정보를 표시해준다.
    - 다른 사용자들의 바다에서 찍은 사진을 SNS의 형식으로 보여준다.
    - 자신의 사진을 SNS에 올릴 수 있다.
    - 사용자와 연결된 사용자(커플)은 생성된 사진에 대해서 접근할 수 있게 된다.
## 📖 목차
- [바다만봐도조아](#바다만봐도조아)
  - [앱소개](#앱소개)
  - [📖 목차](#-목차)
  - [🛠 기능 소개](#-기능-소개)
  - [🤔 고민한 점](#-고민한-점)
    - [아키텍쳐에 대한 고민](#아키텍쳐에-대한-고민)
  - [🚀 트러블 슈팅](#-트러블-슈팅)
  - [🧑‍💻 추가적으로 공부할점](#-추가적으로-공부할점)
  - [🔗 참고 링크](#-참고-링크)

## 🛠 기능 소개
|사용자 맵 화면|사용자 맵 이벤트 반응|
|---|---|
|<img src="../OceanMakeMeHappy/Previews/MapPreview.PNG" width = 180>|<img src="../OceanMakeMeHappy/Previews/MapPreview.gif" width=180>|

## 🤔 고민한 점
### 아키텍쳐에 대한 고민
 `SwiftUI` 내에서 어떤 아키텍쳐를 활용하는 것이 좋을것인가에 대한 고민을 처음부터 하게 된 것은 아닙니다. 하지만, `UIKit`에서 활용하던 MVVM을 통해서 작성하는 과정에서 고민을 시작하게 되었습니다. 고민을 시작하게 된 이유는 MVVM을 지키기 위해서 굉장히 많은 소스코드를 작성하였지만, 간단한 값에 대한 접근을 `ViewModel`이라는 타입에 접근하는 것이 적절하지 않다고 판단하였기 때문입니다.

 MVVM 아키텍쳐는 Binding이라는 작업을 하는 것이 중요하다고 생각하였습니다. 하지만, `SwiftUI`의 기본적인 뷰를 작성하는 방법에 이미 반영되어 있다는 생각이 들었습니다. 그 이유는 `SwiftUI`는 기본적으로 `State, Binding`과 같은 속성을 지정함으로써 프로퍼티의 변화에 따라서 뷰를 다시 렌더링하는 시스템을 가지고 있습니다. 이는 전통적인 MVVM에서의 Binding에 대한 작업이기 때문입니다.

 해당 문제를 해결할 수 있는 방법은 많이 존재하였습니다. 단순히 MV의 형태를 가지고 설계를 할 수 있으며, MVVM 패턴을 계속 활용할 수도 있습니다. 그렇다고 MVVM의 패턴이 완전히 구시대적인 아키텍쳐라는 이야기는 아닙니다. 해당 아키텍쳐는 현재에도 굉장히 많은 곳에서 활용되고 있으며, 단지 선언형 UI를 활용하는 방식에서 적절하지 않을 수 있다는 이야기 입니다.

 그렇다면 어떤 아키텍쳐가 적절한가에 대한 질문이 생기게 될 것입니다. 이에 대한 해답은 2가지 선택지가 있습니다.

    1. MV 패턴을 활용하고, Model에 구현한다.
    2. MVI와 같은 단방향 아키텍쳐를 활용한다.

저는 다음과 같은 선택지 중에서 MV 패턴을 활용하는 방법은 비즈니스 로직에 대한 분리가 완전히 불가능하다고 생각하였습니다. 그래서 MVI 아키텍쳐를 활용하는 방법을 사용하려고 하였습니다. 결론적으로 TCA 아키텍쳐를 활용하도록 하였습니다.

## 🚀 트러블 슈팅

## 🧑‍💻 추가적으로 공부할점

## 🔗 참고 링크