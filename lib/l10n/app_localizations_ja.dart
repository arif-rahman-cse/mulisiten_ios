// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'MULiSiTEN';

  @override
  String get home => 'ホーム';

  @override
  String get settings => '設定';

  @override
  String get history => '履歴';

  @override
  String get day => '日';

  @override
  String get week => '週';

  @override
  String get month => '月';

  @override
  String get year => '年';

  @override
  String get scanForDevices => 'デバイスを検索';

  @override
  String get noDevicePaired => 'デバイス未接続';

  @override
  String get scanHint => 'MS200リストバンドを検索してください';

  @override
  String get heartRate => '心拍数';

  @override
  String get bpm => 'BPM';

  @override
  String get temperature => '温度';

  @override
  String get humidity => '湿度';

  @override
  String get ppiChart => 'PPI（ピーク間隔）';

  @override
  String get waitingForData => 'データ待機中...';

  @override
  String get fallDetected => '落下検知';

  @override
  String get fallMessage => '落下が検知されました。\n大丈夫ですか？';

  @override
  String get imOk => '大丈夫です';

  @override
  String get emergency => '緊急通報';

  @override
  String get safe => '安全';

  @override
  String get fall => '落下';

  @override
  String get noGps => 'GPS無し';

  @override
  String get phoneGps => 'スマホGPS';

  @override
  String get ms200Gps => 'MS200 GPS';

  @override
  String get connected => '接続済み';

  @override
  String get connecting => '接続中...';

  @override
  String get scanning => '検索中...';

  @override
  String get disconnected => '未接続';

  @override
  String get scanTitle => 'MS200を検索';

  @override
  String get scanningDevices => 'MS200デバイスを検索中...';

  @override
  String get noDevicesFound => 'デバイスが見つかりません';

  @override
  String get retry => '再試行';

  @override
  String get settingsTitle => '設定';

  @override
  String get device => 'デバイス';

  @override
  String get appSettings => 'アプリ設定';

  @override
  String get userProfile => 'ユーザープロフィール';

  @override
  String get systemSettings => 'システム設定';

  @override
  String get clockSync => '時計同期';

  @override
  String get syncNow => '今すぐ同期';

  @override
  String get syncedSuccess => '同期成功';

  @override
  String get syncFailed => '同期失敗';

  @override
  String get readFromDevice => 'デバイスから読込';

  @override
  String get writeToDevice => 'デバイスに書込';

  @override
  String get read => '読込';

  @override
  String get write => '書込';

  @override
  String get stopSensingWarning => 'パラメータ変更にはセンシングを停止してください';

  @override
  String get cloudUpload => 'クラウドアップロード';

  @override
  String get bufferToCloud => 'バッファーをクラウドへ';

  @override
  String get bufferDesc => '未送信データを定期的にアップロード';

  @override
  String get realtimeUpload => 'リアルタイムアップロード';

  @override
  String get realtimeDesc => 'データをリアルタイムにクラウドへ送信';

  @override
  String get uploadInterval => 'アップロード間隔';

  @override
  String get apiBaseUrl => 'API ベースURL';

  @override
  String get apiKey => 'APIキー';

  @override
  String get localDatabase => 'ローカルデータベース';

  @override
  String get saveToLocalDb => 'ローカルDBに保存';

  @override
  String get saveDesc => 'センシングデータをローカルに保存';

  @override
  String get clearDatabase => 'ローカルDBをクリア';

  @override
  String get clearDbTitle => 'データベースをクリア？';

  @override
  String get clearDbMessage =>
      'ローカルに保存されたすべてのセンシングデータと転倒イベントが削除されます。この操作は取り消せません。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get clear => 'クリア';

  @override
  String get databaseCleared => 'データベースをクリアしました';

  @override
  String get start => '開始';

  @override
  String get stop => '停止';

  @override
  String get scanConnect => '検索 & 接続';

  @override
  String get disconnect => '切断';

  @override
  String get disconnectDialogTitle => 'デバイスから切断しますか？';

  @override
  String get disconnectDialogMessage =>
      'MS200との接続を切り、保存済みのペアリング情報を消去します。再接続するには再度検索が必要です。';

  @override
  String get disconnectFailed => '切断できませんでした';

  @override
  String get disconnectedReconnecting => '切断 — 再接続中...';

  @override
  String get connectedSensing => '接続済み — センシング中';

  @override
  String get age => '年齢';

  @override
  String get heightCm => '身長 (cm)';

  @override
  String get weightKg => '体重 (kg)';

  @override
  String get exerciseHabit => '運動習慣';

  @override
  String get medicalHistory => '病歴';

  @override
  String get syncUser => 'ユーザー同期';

  @override
  String get syncSystem => 'システム同期';

  @override
  String get noDevice => 'デバイスなし';

  @override
  String get initBluetooth => 'Bluetooth初期化中...';

  @override
  String get scanComplete => '検索完了。デバイスが見つかりません。';

  @override
  String get ext96msData => '96ms拡張データ';

  @override
  String get ext96msDesc => '96msでIMUデータを有効化';

  @override
  String get statusIndexMode => 'ステータスインデックスモード';

  @override
  String get siMode => 'ステータスインデックス';

  @override
  String get ppiMode => 'PPIモード';

  @override
  String get storageMode => 'ストレージモード';

  @override
  String get overwriteMode => '連続上書き';

  @override
  String get keepRecords => '記録保持';

  @override
  String get advertiseSetting => 'アドバタイズ設定';

  @override
  String get off => 'OFF';

  @override
  String get dataSensingInterval => 'データセンシング間隔';

  @override
  String get notificationThreshold => '通知閾値';

  @override
  String get beltWarning => 'ベルト警告';

  @override
  String get statusNormal => '正常';

  @override
  String get statusCaution => '注意';

  @override
  String get statusWarning => '警告';

  @override
  String get statusCritical => '危険';

  @override
  String get statusUnknown => '不明';

  @override
  String get noSensingData => 'センシングデータなし';

  @override
  String get noFallEvents => '転倒イベントなし';

  @override
  String get viewDb => 'DB表示';

  @override
  String get dbDebug => 'DBデバッグ';

  @override
  String get yrs => '歳';

  @override
  String get cm => 'cm';

  @override
  String get kg => 'kg';

  @override
  String get ageRange => '0 – 120 歳';

  @override
  String get heightRange => '0 – 250 cm';

  @override
  String get weightRange => '0 – 250 kg';

  @override
  String get medicalHistoryRange => '範囲は0 – 10 で入力してください';

  @override
  String get exerciseNone => 'なし';

  @override
  String get exerciseLight => '軽い';

  @override
  String get exerciseModerate => '普通';

  @override
  String get exerciseHeavy => '激しい';

  @override
  String get min => '分';

  @override
  String get writeSuccess => '設定を保存しました';

  @override
  String get writeFailed => '設定の保存に失敗しました';

  @override
  String get displayName => '表示名';

  @override
  String get displayNameHint => '名前を入力してください';

  @override
  String get enterNameTitle => '名前を入力';

  @override
  String get nameHint => 'あなたの名前';

  @override
  String get saveBtn => '保存';

  @override
  String get cancelBtn => 'キャンセル';

  @override
  String get hiSafe => '安全';

  @override
  String get hiCaution => '注意';

  @override
  String get hiWarning => '警告';

  @override
  String get hiDanger => '危険';

  @override
  String get hiExtremeDanger => '極度危険';

  @override
  String get altitude => '高度';

  @override
  String get fallStatus => '落下検知';

  @override
  String get battery => 'バッテリー';

  @override
  String get todayActivity => '今日のアクティビティ';

  @override
  String get appleHealthSource => 'Apple Health';

  @override
  String get steps => '歩数';

  @override
  String get calories => '消費カロリー';

  @override
  String get kcal => 'kcal';

  @override
  String get activityLoading => '今日のアクティビティを読み込み中...';

  @override
  String get allowAppleHealthAccess => 'Apple Health を許可';

  @override
  String get appleHealthPermissionCta =>
      '今日の歩数と消費カロリーを表示するために Apple Health へのアクセスを許可してください。';

  @override
  String get noActivityDataToday => '今日の Apple Health アクティビティデータはまだありません。';

  @override
  String get activityLoadFailed => '今日の Apple Health アクティビティを読み込めませんでした。';

  @override
  String get altRising => '▲ 上昇';

  @override
  String get altDescending => '▼ 下降';

  @override
  String get altLevel => '— 水平';

  @override
  String get fallStopped => '停止';

  @override
  String get fallMonitoringLow => '低高度';

  @override
  String get fallMonitoringHigh => '高高度';

  @override
  String get fallAlarm => '警報';

  @override
  String get fallInactive => '非アクティブ';

  @override
  String get fallDetectedBadge => '落下検知！';

  @override
  String get historyNoData => 'この期間の履歴データはありません';

  @override
  String get historyLatest => '最新';

  @override
  String get historyAverage => '平均';

  @override
  String get historyMin => '最小';

  @override
  String get historyMax => '最大';

  @override
  String get historyTotalFalls => '転倒回数';

  @override
  String get historyRecentFalls => '最近の転倒イベント';

  @override
  String get aboutLegal => 'アプリについて';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get cloudConsentTitle => 'クラウドデータアップロード';

  @override
  String get cloudConsentMessage =>
      '有効にすると、MS200リストバンドから取得した以下のデータがクラウドサーバーに送信されます：\n\n• 心拍数 & PPI間隔\n• 体温 & 湿度\n• GPS位置情報（デバイスまたはスマートフォン）\n• 転倒検知ステータス\n• お名前\n\nデータはHTTPSで安全に送信されます。アップロードは設定からいつでも無効にできます。';

  @override
  String get cloudConsentAgree => '同意して有効化';

  @override
  String get cloudConsentDecline => 'キャンセル';

  @override
  String get locationRationaleTitle => '位置情報へのアクセスが必要です';

  @override
  String get locationRationaleMessage =>
      'MS200 Companionは、リストバンドにGPS信号がない場合にスマートフォンのGPSで健康データに位置情報を付与し、転倒検知時の位置を記録します。\n\nバックグラウンド位置情報へのアクセスにより、アプリが最小化されていても継続的にモニタリングできます。';

  @override
  String get locationRationaleContinue => '続行';
}
