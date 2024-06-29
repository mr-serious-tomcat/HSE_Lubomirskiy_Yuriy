def roman_to_int(roman_string):

  roman_values = {'M': 1000, 'CM': 900, 'D': 500, 'CD': 400, 'C': 100, 'XC': 90, 'L': 50, 'XL': 40, 'X': 10, 'IX': 9, 'V': 5, 'IV': 4, 'I': 1}
  integer = 0
  i = 0
  while i < len(roman_string):
    if i + 1 < len(roman_string) and roman_string[i:i+2] in roman_values:
      integer += roman_values[roman_string[i:i+2]]
      i += 2
    else:
      integer += roman_values[roman_string[i]]
      i += 1
  return integer


print(roman_to_int("MMX"))
