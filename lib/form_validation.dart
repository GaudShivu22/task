String? validateNumericalInput(String? input) {


  if (input == null || input.isEmpty) {
    return 'This field cannot be empty';
  }
  final isNumeric = int.tryParse(input) != null;
   if (!isNumeric) {
    return 'Please enter a valid number';
  }
  else
    {
    return null;
    }

}
