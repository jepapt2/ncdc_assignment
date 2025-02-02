# NCDC Assignment

## 実行環境

- Flutter 3.27.3
- Dart 3.6.1
- Java 17
- Xcode 16.2
- cocoapod 1.15.2

## 主な使用パッケージ

- hooks_riverpod (^2.6.1)
  - アプリ全体の状態管理とプロバイダーパターンの実装に使用
- flutter_hooks (^0.20.5)
  - スクリーンを跨がない簡易な状態管理などに使用
- freezed (^2.5.8)
  - content 用クラス作成のため使用(fromJson など)
- go_router (^14.7.2)
  - routing 設定のため使用
- dio (^5.0.0)
  - api との通信のため使用

## 指定デザインとの相違点

スマートフォンの画面領域に合わせるため、以下の点を変更しました

- サイドバーのコンテンツリストと本文部分を別々のスクリーンに分離
- 新規作成とタイトル編集をダイアログ化
- 本文の編集、保存ボタンを FloatingActionButton に変更
- title の文字サイズを 24 から 20 に変更

## ディレクトリ構成

```
lib/
├── core/                   # コアモジュール
│   ├── hooks/             # カスタムフック
│   │   └── use_api.dart   # API通信の抽象化
│   ├── providers/         # 共通のプロバイダー
│   │   └── dio_provider/  # HTTP通信の設定
│   └── utils/            # ユーティリティ関数
│
├── features/              # 機能モジュール
│   └── content/          # コンテンツ機能
│       ├── hooks/        # 機能固有のフック
│       ├── models/       # データモデル
│       ├── providers/    # 状態管理
│       └── views/        # UI実装
│
└── main.dart             # エントリーポイント

test/                     # テストコード
├── core/                 # コアモジュールのテスト
├── features/            # 機能モジュールのテスト
└── test_helper.dart     # テストヘルパー
```
