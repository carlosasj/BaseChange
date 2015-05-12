#01 Ler
- Ler BaseIn
- Ler BaseOut
- Ler Numero (em string, colocar o limite correspondente)

#02 IF BaseIn == BaseOut
- IF (BaseIn == BaseOut){
	Print(input)
	[Sai do programa]
}

#03 Converte Número para Binário
```
IF (BaseIn == 2) {
  binary[i] <= input[i].toInt
}
ELSE IF (BaseIn == 8){
	binary <= ConvertFrom8(input)
}
ELSE IF (BaseIn == 10){
	binary <= ConvertFrom10(input)
}
ELSE IF (BaseIn == 16){
	binary <= ConvertFrom16(input)
}
```
#04 Converte Binário para Número
```
IF (BaseOut == 2) {
  String[i] <= binary[i].toString
}
ELSE IF (BaseOut == 8){
	String <= ConvertTo8(binary)
}
ELSE IF (BaseOut == 10){
	String <= ConvertTo10(binary)
}
ELSE IF (BaseOut == 16){
	String <= ConvertTo16(binary)
}
```

#04 Print String
- Imprimir os textos junto com as bases e o número final

#05 Sair do programa
