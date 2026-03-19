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
  String get analytics => '分析';

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
  String get fallDetected => '転倒検知';

  @override
  String get fallMessage => '転倒が検知されました。\n大丈夫ですか？';

  @override
  String get imOk => '大丈夫です';

  @override
  String get emergency => '緊急通報';

  @override
  String get safe => '安全';

  @override
  String get fall => '転倒';

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
}
