class MedicineCabinent {
  MedicineCabinent(
      {required this.cabinetId, required this.userId, required this.medicine});

  factory MedicineCabinent.fromMap(Map<String, dynamic> data) {
    return MedicineCabinent(
      cabinetId: data['cabinetId'],
      userId: data['userId'],
      medicine: data['medicine'],
    );
  }

  final String cabinetId;
  final String userId;
  final List<dynamic> medicine;
}
