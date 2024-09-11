
![preview](https://github.com/xpwmaosldk/number_pagination/assets/13146337/aed48430-96de-43ec-8864-dc75cae9a197)

# number_pagination [![flutter](https://img.shields.io/badge/Flutter-027DFD)](https://flutter.dev/) ![flutter test](https://github.com/xpwmaosldk/number_pagination/actions/workflows/flutter_test.yml/badge.svg) [![package](https://img.shields.io/badge/pub.dev-number__pagenation-0553B1)](https://pub.dev/packages/number_pagination) 

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/Q5Q8BWZF)

Implementing Flutter Number Pagination using a Popular Web Approach.

This package is very simple. Without depending on other packages.

Its usage is also simple and easy.

[![document](https://img.shields.io/badge/Document-F25D50)](https://pub.dev/documentation/number_pagination/latest/number_pagination/NumberPagination-class.html)
# NumberPagination

A customizable pagination widget for Flutter applications.

## Overview

NumberPagination is a Flutter widget that provides an intuitive and flexible way to implement pagination in your applications. It displays page numbers and navigation controls, allowing users to easily navigate through multiple pages of content.

## Features

- Page number buttons
- Navigation controls (first, previous, next, last)
- Customizable appearance
- Responsive design

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  number_pagination: ^1.1.0
```

| Property                   | Type          | Default                          | Description                                                 |
| -------------------------- | ------------- | -------------------------------- | ----------------------------------------------------------- |
| onPageChanged              | Function(int) | Required                         | Callback function triggered when the page changes.          |
| totalPages                 | int           | Required                         | Total number of pages available.                            |
| currentPage                | int           | 1                                | Currently displayed page number.                            |
| visiblePagesCount          | int           | 10                               | Number of page buttons to display at once.                  |
| activeColor                | Color         | Colors.black                     | Color of the active page number and icons.                  |
| inactiveColor              | Color         | Colors.white                     | Background color for the inactive buttons.                  |
| fontSize                   | double        | 15                               | Font size for the page numbers.                             |
| fontFamily                 | String?       | null                             | Font family for the page numbers.                           |
| buttonElevation            | double        | 5                                | Elevation of the buttons.                                   |
| buttonRadius               | double        | 10                               | Radius of the buttons.                                      |
| firstPageIcon              | Widget        | Icon(Icons.first_page)           | Icon for the "first page" button.                           |
| previousPageIcon           | Widget        | Icon(Icons.keyboard_arrow_left)  | Icon for the "previous page" button.                        |
| nextPageIcon               | Widget        | Icon(Icons.keyboard_arrow_right) | Icon for the "next page" button.                            |
| lastPageIcon               | Widget        | Icon(Icons.last_page)            | Icon for the "last page" button.                            |
| navigationButtonSpacing    | double        | 4.0                              | Spacing between navigation buttons.                         |
| sectionSpacing             | double        | 10.0                             | Spacing between navigation buttons and page number buttons. |
| controlButtonSize          | Size          | Size(48, 48)                     | Size of the control buttons.                                |
| numberButtonSize           | Size          | Size(48, 48)                     | Size of the number buttons.                                 |
| betweenNumberButtonSpacing | double        | 3                                | Spacing between individual number buttons.                  |