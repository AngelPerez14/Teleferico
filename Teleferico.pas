program Teleferico;
uses crt;
var
  opmenu, opsistema, cantboletos, cantAdultos, cantTerceraEdad, cantNinos, precio, preciototal, TotalAdultos, TotalNinos, TotalTerceraEdad : Integer;
  nombre, apellido, tramo: String;
  cedula: LongInt;
  valido: Boolean;
  asientosdispo, asientotales: Integer;
  hayMenorDeTres: Char;
  continuar: Boolean;

begin
	TotalAdultos := 20;
	TotalNinos := 12;
	TotalTerceraEdad :=12;
  asientosdispo := 60;  // Numero total de asientos disponibles al inicio
  asientotales := asientosdispo;
  continuar := True; //Para que el programa no se cierre al terminar una compra o consulta

  while continuar do //Conservar el bucle
  begin
    clrscr; // Limpiar pantalla
    writeln('-----------------------------------------------');
    WriteLn('Menu Principal:');
    writeln('-----------------------------------------------');
    WriteLn('1. Comprar boleto');
    WriteLn('2. Ver sistema');
    WriteLn('3. Salir');
    writeln('-----------------------------------------------');
    Write('Seleccione una opcion: ');
    ReadLn(opmenu); //opcion del usuario
    
    clrscr; //limpiar pantalla
    
    case opmenu of
      1:         // Comprar boleto
      begin
        repeat
		 Writeln('Por favor, ingrese su nombre: ');
          ReadLn(nombre);
          valido := True;
          for cantAdultos := 1 to Length(nombre) do
          begin
            if not (nombre[cantAdultos] in ['A'..'Z', 'a'..'z']) then //Para que el usuario no coloque numeros
            begin
              valido := False;
              WriteLn('Nombre no valido. Solo se permiten letras.');
              Break;
            end;
          end;
        until valido;

        repeat
          Writeln('Por favor, ingrese su apellido: ');
          ReadLn(apellido);
          valido := True;
          for cantAdultos := 1 to Length(apellido) do
          begin
            if not (apellido[cantAdultos] in ['A'..'Z', 'a'..'z']) then
            begin
              valido := False;
              WriteLn('Apellido no valido. Solo se permiten letras.');
              Break;
            end;
          end;
        until valido;

        Write('Ingrese su cedula: ');
        ReadLn(cedula);
        WriteLn('Bienvenido ', nombre, ' ', apellido);
        clrscr; // Limpiar pantalla

        repeat
          Write('Cuantas personas viajaran?: ');
          ReadLn(cantboletos);
          if (cantboletos <= 0) or (cantboletos > 60) then
            WriteLn('El numero de boletos debe estar entre 1 y 60. Por favor, intente de nuevo.');
        until (cantboletos > 0) and (cantboletos <= 60);

        Write('¿Cuantos boletos son para adultos? ');
        ReadLn(cantAdultos);
        Write('¿Cuantos boletos son para personas de tercera edad (mayores de 60 años)? ');
        ReadLn(cantTerceraEdad);
        Write('¿Cuantos boletos son para niños (menores de 12 años)? ');
        ReadLn(cantNinos);

        if cantAdultos + cantTerceraEdad + cantNinos <> cantboletos then
        begin
          WriteLn('Error: La suma de boletos no coincide con el total. Por favor, intente de nuevo.');
          ReadLn; // Esperar a que el usuario presione Enter
          Continue;
        end;

        clrscr; // Limpiar pantalla

        writeln('Ahora digame hacia que tramo se dirige');
        writeln('1. Barinitas - La montana');
        writeln('2. La montana - La aguada');
        writeln('3. La aguada - Loma redonda');
        writeln('4. Loma redonda - Pico espejo');
        ReadLn(tramo);

        case tramo of
          '1': precio := 5 ;
          '2': precio := 10;
          '3': precio := 15;
          '4': precio := 20;
        else
          begin
            writeln('El tramo que ha seleccionado no existe');
            precio := 0; // En caso de que el tramo sea invalido, el precio sera 0
          end;
        end;
        clrscr; // Limpiar pantalla

        if tramo = '4' then
        begin
          Write('¿Hay algun nino menor de 3 anos en el grupo? (S/N): ');
          ReadLn(hayMenorDeTres);
          if UpCase(hayMenorDeTres) = 'S' then
          begin
            WriteLn('Error: Los ninos menores de 3 anos no pueden viajar en el ultimo tramo.');
            ReadLn; // Esperar a que el usuario presione Enter
            Continue;
          end;
        end;

        preciototal := (cantAdultos * TotalAdultos) + (cantTerceraEdad * TotalTerceraEdad) + (cantNinos * TotalNinos) + (cantboletos * precio);

        WriteLn('El precio total de los boletos es: ', preciototal, '$');
        
        // Restar los boletos vendidos de los asientos disponibles
        asientotales := asientotales - cantboletos;
        
        ReadLn; // Esperar a que el usuario presione Enter
      end;
      2:
      begin
        WriteLn('Ha seleccionado ver el sistema.');
        WriteLn('1. Información de boletos vendidos');
        WriteLn('2. Número de asientos disponibles');
        WriteLn('3. Reporte de ventas');
        ReadLn(opsistema);
        case opsistema of
          1: WriteLn('Se han vendido ', asientosdispo - asientotales, ' boletos de tipo ', tramo);
          2: WriteLn('Numero de asientos disponibles: ', asientotales);
          3:
          begin
            WriteLn('Reporte de ventas:');
            WriteLn('Total boletos vendidos: ', asientosdispo - asientotales);
            WriteLn('Total ingresos: ', preciototal, '$');  
          end;
        else
          WriteLn('Opcion no valida. Por favor, intente de nuevo.');
        end;
        ReadLn; // Esperar a que el usuario presione Enter
      end;
      3:
      begin
        WriteLn('Gracias por usar el sistema. ¡Hasta luego!');
        continuar := False;
      end;
    else
      WriteLn('Opcion no valida. Por favor, intente de nuevo.');
      ReadLn; // Esperar a que el usuario presione Enter
    end;
  end;
end.
