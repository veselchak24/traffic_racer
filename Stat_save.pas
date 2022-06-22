unit Stat_save;

type
  
  Statist = class
    procedure Save_all(max_speed: real);
    begin
      if not FileExists('statistic') then 
       begin
       Stat_file := CreateFileReal('statistic');
       Write(Stat_file,0);
       Close(Stat_file);
       end;
      Stat_file := OpenFileReal('statistic');
      if max_speed > Stat_file.Read then
      begin
      Rewrite(Stat_file);
      Write(Stat_file, max_speed);
     end; 
      Close(Stat_file);
    end;
    
    function GetData(NameData: string): real;
    begin
      Stat_file := OpenFileReal('statistic');
      var a: real;
      case NameData of
        'speed':
          begin
            a := Stat_file.Read;
          end;
      end;

      Close(Stat_file);
      Result := a; // если не ввести переменную a,то до close не дойдёт цепочка
    end;
  
  private
    Stat_file: file of real;
  //Speed := 
end;
end.