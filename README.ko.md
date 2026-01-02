<p align="right">
  <a href="README.md">繁體中文</a> |
  <a href="README.en.md">EN</a> |
  <a href="README.ja.md">JP</a> |
  <a href="README.ko.md">KR</a>
</p>

<p align="left">
  <img src="https://img.shields.io/badge/Swift-5.9-orange">
  <img src="https://img.shields.io/badge/SwiftUI-iOS-blue">
  <img src="https://img.shields.io/badge/iOS-17+-lightgrey">
  <img src="https://img.shields.io/badge/MapKit-Apple-green">
  <img src="https://img.shields.io/badge/FastAPI-Backend-teal">
  <img src="https://img.shields.io/badge/Status-Demo-success">
</p>

## 프로젝트 설명

본 프로젝트는 SwiftUI로 개발된 iOS 앱입니다.
정부 개방 데이터셋 「그린 라이프 _ 그린 스토어」 JSON 파일을 읽고 분석하여,
타이중시의 그린 스토어를 지도 마커(Map Annotation) 형태로 표시합니다.

본 앱은 Swift의 Codable 메커니즘을 사용하여 JSON 데이터를 디코딩하며,
MapKit(또는 SwiftUI Map) 을 결합하여 상점 위치를 인터랙티브 지도에 표시합니다.
사용자는 지도를 확대 및 이동할 수 있으며,
마커를 탭하여 상점의 상세 정보
(행정 코드, 항목 번호, 시/현 구분, 상점명, 주소, 전화번호 등)를 확인할 수 있습니다.

## 사용 전 주의 사항

본 앱은 프론트엔드와 백엔드를 분리한 구조를 사용하며,
본 프로젝트에서 제공하는 FastAPI 백엔드 서비스와 함께 사용해야 합니다.

먼저 Doc 폴더에 있는 FastAPI 백엔드를 실행하여
API 서비스가 정상적으로 동작하는지 확인한 후 iOS 앱을 실행해 주세요.
그렇지 않을 경우 앱은 그린 스토어 데이터를 가져올 수 없으며,
지도에도 마커가 표시되지 않습니다.

API가 정상적으로 데이터를 반환하는 것을 확인한 후 앱을 실행해 주세요.

## 소기능 시연

<div align="center">
  <table>
    <tr>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/demo.gif" width="200" alt="API 연동 데모"><br>
        <b>API 연동 데모</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/lookAround.gif" width="200" alt="둘러보기 기능"><br>
        <b>그린 스토어 둘러보기 화면 표시</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/showDirections.gif" width="200" alt="경로 표시 기능"><br>
        <b>사용자에서 그린 스토어까지의 경로 표시</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/likeButtonFunc.gif" width="200" alt="즐겨찾기 매장 표시"><br>
        <b>사용자가 즐겨찾기한 매장 표시</b>
      </td>
    </tr>
  </table>
</div>

## 전체 기능 시연

<div align="center">
    <td align="center" style="padding: 0 20px;">
        <img src="Docs/Compelet1.gif" width="200" alt="전체 기능"><br>
    </td>
</div>

## 라이선스

본 프로젝트의 소스 코드는 본 저장소의 LICENSE 파일을 기준으로 라이선스가 적용됩니다.
해당 파일이 제공되지 않은 경우, 학습 및 시연 목적으로만 사용됩니다.

데이터셋의 저작권 및 사용 규정은 정부 개방 데이터 플랫폼의 라이선스 약관을 따릅니다.
