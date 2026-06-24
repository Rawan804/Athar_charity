class BeneficiaryRequest {
  final String first_name;
  final String father_name;
  final String mother_name;
  final String email;
  final String phone;
  final String password;
  final String password_confirmation;
  final String address_en;
  final String address_ar;
  final bool is_male;
  final bool is_male_breadwinner_for_family;
  final bool is_female_breadwinner_for_family;
  final bool is_family_breadwinner;
  final bool is_girl_without_family;
  final bool has_family;
  final bool is_orphan;
  final bool is_injured;
  final bool is_disabled;
  final String total_number_of_children;
  final String number_of_disabled_children;
  final String description_en;
  final String description_ar;

  BeneficiaryRequest({
    required this.first_name,
    required this.father_name,
    required this.mother_name,
    required this.email,
    required this.phone,
    required this.password,
    required this.password_confirmation,
    required this.address_en,
    required this.address_ar,
    required this.is_male,
    required this.is_male_breadwinner_for_family,
    required this.is_female_breadwinner_for_family,
    required this.is_family_breadwinner,
    required this.is_girl_without_family,
    required this.is_orphan,
    required this.has_family,
    required this.is_injured,
    required this.is_disabled,
    required this.total_number_of_children,
    required this.number_of_disabled_children,
    required this.description_en,
    required this.description_ar,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": first_name,
      "father_name": father_name,
      "mother_name": mother_name,
      "address_en": address_en,
      "address_ar": address_ar,
      "phone": phone,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "is_male": is_male,
      "has_family": has_family,
      "is_male_breadwinner_for_family": is_male_breadwinner_for_family,
      "is_female_breadwinner_for_family": is_female_breadwinner_for_family,
      "is_family_breadwinner": is_family_breadwinner,
      "is_youth_without_family": false,
      "is_girl_without_family": is_girl_without_family,
      "is_orphan": is_orphan,
      "is_injured": is_injured,
      "is_disabled": is_disabled,
      "total_number_of_children": total_number_of_children,
      "number_of_disabled_children": number_of_disabled_children,
      "description_en": description_en,
      "description_ar": description_ar,
    };
  }
}
