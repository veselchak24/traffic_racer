unit Меню;

uses WPFObjects, Stat_save, События;

type
  Menu = class
    procedure DrawMenu;
    begin
      backgroundLobby := PictureWPF.Create(0, 0, 'pictures\logo.png');
      
      Play := RectangleWPF.Create(Window.Width / 3, Window.Height / 4, 420, 100, Colors.Green);
      text_Play := TextWPF.Create(Window.Width / 2.5, Window.Height / 4, 'Начать', Colors.Blue);
      text_Play.FontSize := 80;
      
      Stat := RectangleWPF.Create(Window.Width / 3, Window.Height / 2.5, 420, 100, Colors.Blue);
      text_Stat := TextWPF.Create(Window.Width / 3, Window.Height / 2.5, 'Статистика', Colors.Green);
      text_Stat.FontSize := 80;
      
      Quit := RectangleWPF.Create(Window.Width / 3, Window.Height / 1.8, 420, 100, Colors.Blue);
      text_Quit := TextWPF.Create(Window.Width / 2.4, Window.Height / 1.8, 'Выход', Colors.Red);  
      text_Quit.FontSize := 80;
      
    end;
    
    procedure DestroyMenu;
    begin
      Play.Destroy;
      Stat.Destroy;
      Quit.Destroy;
      text_Play.Destroy;
      text_Quit.Destroy;
      text_Stat.Destroy;
    end;
    
    procedure OpenStat;
    begin
      DestroyMenu;
      OnMouseDown := nil;
      var Speed : TextWPF;
        if not FileExists('statistic') then
      begin
      Speed := TextWPF.Create(Window.Width / 3, Window.Height / 4, 'Вы не сыграли ни одной игры!', colors.Red)
      end
      else
      begin
        Speed := TextWPF.Create(Window.Width / 3, Window.Height / 4, 'max_speed = ' + stat_file.GetData('speed'), colors.Green);
        Speed.FontSize := 50;
      end;
      OnKeyDown := (K: Key) ->
      begin
        if K = Key.Escape then
        begin
          Speed.Destroy;
          DrawMenu;
          OnMouseDown := MenuMouseDown;
        end;
      end;
    end;
    
    procedure MenuMouseDown(x, y: real; m: integer);
    begin
      if x.Between(Stat.Left, Stat.Left + Stat.Width) and y.Between(Stat.Top, Stat.Height + Stat.Top) then
        OpenStat else
      if x.Between(Play.Left, Play.Left + Play.Width) and y.Between(Play.Top, Play.Top + Play.Height) then 
      begin
        start_check := false;
        DestroyMenu;
        backgroundLobby.Destroy;
      end
      else if x.Between(Quit.Left, Quit.Left + Quit.Width) and y.Between(Quit.Top, Quit.Top + Quit.Height) then Halt;
      
    end;
    
    
    {
    procedure DrawLastMenu(&IsRestart: boolean);
    begin
      backgroundLobby := PictureWPF.Create(0, 0, '..\crazy traffic\pictures\logo.png');
      
      var Rules := events.Create;
      Rules.GameBreak := false;
      start_check := true;
      
      Go_Menu_Back := RectangleWPF.Create(120, Window.Width / 1.6, 400, 100, Colors.Blue);
      text_Go_Menu_Back := TextWPF.Create(120, Window.Height / 1.6, 'Вернуться в главное меню', Colors.Red);
      text_Go_Menu_Back.FontSize := 30;
      
      Quit := RectangleWPF.Create(Window.Width - 400, Window.Height / 1.6, 200, 100, Colors.Blue);
      text_Quit := TextWPF.Create(Window.Width - 400, Window.Height / 1.6, 'Выход', Colors.Red);  
      text_Quit.FontSize := 40;
      
      OnMouseDown := (x, y: real; m: integer) ->
      begin
        if x.Between(Go_Menu_Back.Left, Go_Menu_Back.Left + Go_Menu_Back.Width)
              and y.Between(Go_Menu_Back.Top, Go_Menu_Back.Top + Go_Menu_Back.Height)
        then
        begin
          Quit.Destroy;
          text_Quit.Destroy;
          Go_Menu_Back.Destroy;
          text_Go_Menu_Back.Destroy;
          
          IsRestart := true;
          backgroundLobby.Destroy;
          //DrawMenu;
          //OnMouseDown := MenuMouseDown;
        end
        else if x.Between(Quit.Left, Quit.Left + Quit.Width) and y.Between(Quit.Top, Quit.Top + Quit.Height) then Halt;
      end;
    end;
    }
    public start_check := true;
  private
    backgroundLobby: PictureWPF;
    
    Play, Stat, Quit: RectangleWPF;
    text_Play, text_Stat, text_Quit: TextWPF;
    stat_file := Statist.Create;
    
    Go_Menu_Back: RectangleWPF;
    text_Go_Menu_Back: TextWPF;
  end;

end.