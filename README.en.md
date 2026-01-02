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

## Project Description

This project is an iOS App developed with SwiftUI.
It is used to read and parse the government open dataset “Green Living _ Green Stores” in JSON format,
and display green stores in Taichung City on a map using Map Annotations.

The App uses Swift’s Codable mechanism to decode JSON data,
and integrates MapKit (or SwiftUI Map) to present store locations on an interactive map.
Users can zoom and pan the map, and tap on annotations to view detailed store information
(administrative code, item number, city, store name, address, phone number, etc.).

## Notes Before Use

This App adopts a frontend-backend separated architecture,
and must be used together with the FastAPI backend service provided in this project.

Please start the FastAPI backend (located in the Doc folder) first.
After the API service is successfully running, then launch the iOS App.
Otherwise, the App will not be able to retrieve green store data,
and no annotations will be displayed on the map.

Please make sure the API can return data correctly before opening the App.

## Feature Demonstration

<div align="center">
  <table>
    <tr>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/demo.gif" width="200" alt="API Integration Demo"><br>
        <b>API Integration Demo</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/lookAround.gif" width="200" alt="Look Around Feature"><br>
        <b>Display Look Around view of green stores</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/showDirections.gif" width="200" alt="Show Directions Feature"><br>
        <b>Display route from user to green store</b>
      </td>
      <td align="center" style="padding: 0 20px;">
        <img src="Docs/likeButtonFunc.gif" width="200" alt="Favorite Stores"><br>
        <b>Display user’s favorite stores</b>
      </td>
    </tr>
  </table>
</div>

## Overall Function Demonstration

<div align="center">
    <td align="center" style="padding: 0 20px;">
        <img src="Docs/Compelet1.gif" width="200" alt="Overall functionality"><br>
    </td>
</div>

## License

The license of this project’s source code is subject to the LICENSE file in this repository.
If not provided, it is intended for learning and demonstration purposes only.

The copyright and usage terms of the dataset follow the license terms of the government open data platform.
