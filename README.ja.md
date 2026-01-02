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

## プロジェクト説明

本プロジェクトは SwiftUI を用いて開発された iOS アプリです。
政府のオープンデータセット 「グリーンライフ＿グリーンストア」 の JSON ファイルを読み込み・解析し、
台中市のグリーンストアを 地図上のマップアノテーション として表示します。

本アプリは Swift の Codable 機構を使用して JSON をデコードし、
MapKit（または SwiftUI Map） と連携して、店舗の位置情報をインタラクティブな地図上に表示します。
ユーザーは地図を拡大・縮小、移動することができ、
マーカーをタップすることで店舗の詳細情報
（行政コード、項次、県市別、店舗名、住所、電話番号など）を確認できます。

## 使用前の注意事項

本アプリは フロントエンドとバックエンドを分離した構成 を採用しており、
本プロジェクトに含まれる FastAPI バックエンドサービス と併用する必要があります。

まず Doc フォルダ 内の FastAPI バックエンドを起動し、
API サービスが正常に動作していることを確認してから、iOS アプリを起動してください。
そうでない場合、アプリはグリーンストアのデータを取得できず、
地図上にもマーカーは表示されません。

API が正常にデータを返すことを確認した後で、アプリを起動してください。

## 小機能デモ

<div align="center">
  <table>
    <tr>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/demo.gif" width="200" alt="API 連携デモ"><br>
        <b>API 連携デモ</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/lookAround.gif" width="200" alt="ルックアラウンド機能"><br>
        <b>グリーンストアのルックアラウンド表示</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/showDirections.gif" width="200" alt="ルート表示機能"><br>
        <b>ユーザーからグリーンストアまでのルート表示</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/likeButtonFunc.gif" width="200" alt="お気に入り店舗表示"><br>
        <b>ユーザーのお気に入り店舗を表示</b>
      </td>
    </tr>
  </table>
</div>

## 全体的な機能デモ

<div align="center">
    <td align="center" style="padding: 0 20px;">
        <img src="Docs/Compelet1.gif" width="200" alt="全体的な機能"><br>
    </td>
</div>

## ライセンス

本プロジェクトのソースコードのライセンスは、本リポジトリ内の LICENSE ファイルに準拠します。
提供されていない場合は、学習およびデモ用途のみを目的とします。

データセットの著作権および利用規約は、政府オープンデータプラットフォームのライセンス条項に従います。
