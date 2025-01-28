class PrayerSchedule {
  final String id;
  final String mosqueId;
  final DateTime date;
  final List<PrayerSegment> segments;
  final String ramadanDay;

  PrayerSchedule({
    required this.id,
    required this.mosqueId,
    required this.date,
    required this.segments,
    required this.ramadanDay,
  });

  factory PrayerSchedule.fromJson(Map<String, dynamic> json) {
    return PrayerSchedule(
      id: json['id'] as String,
      mosqueId: json['mosqueId'] as String,
      date: DateTime.parse(json['date'] as String),
      segments: (json['segments'] as List)
          .map((segment) => PrayerSegment.fromJson(segment))
          .toList(),
      ramadanDay: json['ramadanDay'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mosqueId': mosqueId,
      'date': date.toIso8601String(),
      'segments': segments.map((segment) => segment.toJson()).toList(),
      'ramadanDay': ramadanDay,
    };
  }
}

class PrayerSegment {
  final String id;
  final String imamId;
  final String imamName;
  final String prayerType; // e.g., "Isha", "Taraweeh", "Tahajjud"
  final String description; // e.g., "First 4 rakats"
  final DateTime startTime;
  final DateTime endTime;

  PrayerSegment({
    required this.id,
    required this.imamId,
    required this.imamName,
    required this.prayerType,
    required this.description,
    required this.startTime,
    required this.endTime,
  });

  factory PrayerSegment.fromJson(Map<String, dynamic> json) {
    return PrayerSegment(
      id: json['id'] as String,
      imamId: json['imamId'] as String,
      imamName: json['imamName'] as String,
      prayerType: json['prayerType'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imamId': imamId,
      'imamName': imamName,
      'prayerType': prayerType,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
    };
  }
}
