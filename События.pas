unit События;

uses GraphWPF, WPFObjects, Healths, Stat_save;

label RepeatCheck;

var
  speed_road := 0.7;

type
  Enemys = class
    procedure CreateEnemy(val: integer);
    begin
      Enemy := new PictureWPF[val];

      for var i := 0 to val - 1 do
      begin
        Enemy[i] := PictureWPF.Create(Random(140, 745), Random(-200, 10), 'pictures\Traffic' + (i + 1) + '.png');
        if i >= 1 then 
          for var j := 0 to i do
            if i <> j then
              while ObjectsIntersect(Enemy[i], Enemy[j]) do
                Enemy[i].MoveTo(Random(140, 745), Random(-200, 10));
      end;
       
      value_enemy := val;
      
      TextWPF.Create(0, 0, 'Speed:', colors.Blue).FontSize := 30;
      
      score_speed := TextWPF.Create(95, 0, speed_road.ToString, Colors.Red);
      score_speed.FontSize := 30;
    end;
    
    procedure EnemyMove;
    begin
      for var i := 0 to Enemy.Length - 1 do
        if Enemy[i].Top < Window.Height then
        begin
          Enemy[i].MoveBy(0, speed_road - speed_road / 1.5);
          if Enemy[i].Top > Window.Height then 
          begin
            Enemy[i].MoveTo(Random(140, 745), Random(-400, -200));
            for var j := 0 to Enemy.Length - 1 do
              if i <> j then
                while Enemy[i].Intersects(Enemy[j]) do
                  Enemy[i].MoveTo(Random(140, 745), Random(-400, -200));        
            
            
            speed_road += Random(1, 2) / 20;
            score_speed.Text := speed_road.ToString;
          end;
        end;
    end;
    
    function GetEnemy(i: integer): PictureWPF := Enemy[i];
    protected value_enemy := 0;
  
  private
    static Enemy: array of PictureWPF;
    score_speed: TextWPF;
  end;
  
  Events = class
  public
    procedure CreateLvL;
    begin
      Road[0] := PictureWPF.Create(0, 0, 'pictures\дорога.png');
      Road[1] := PictureWPF.Create(0, -Window.Height + 8, 'pictures\дорога.png');
      Player := PictureWPF.Create(Window.Width / 2, Window.Height / 2, 'pictures\car.png');
      Heart.CreateHeart;
      for var i := 0 to 2 do
        icon_healph[i] := PictureWPF.Create(i * 30, 50, 'pictures\Healph.png');
    end;
    
    procedure CarMove(K: Key);
    begin
      BeginFrameBasedAnimation(
      () ->
      begin
        case K of
          Key.Escape: score_healph := 0;
          Key.D, Key.Right:
          if Player.Left.Between(140, 745) then Player.MoveBy(5, 0); 
          Key.A, Key.Left: if Player.Left.Between(180, 750) then Player.MoveBy(-5, 0);
        end;
      end);
    end;
    
    procedure CheckRules();
    begin
      RoadMove;
      Enemy.EnemyMove;
      IsDTP;
      Heart.HealphMove(speed_road);
      AddHealph;
      if score_healph = 0 then
        GameOver;
    end;
    
    procedure IsDTP;
    begin
      for var i := 0 to Enemy.value_enemy - 1 do
        if ObjectsIntersect(Player, Enemy.GetEnemy(i)) then 
        begin
          icon_healph[score_healph - 1].Destroy;
          icon_healph[score_healph - 1] := PictureWPF.Create((score_healph - 1) * 30, 50, 'pictures\No_Healph.png');    
          score_healph -= 1;
          Enemy.GetEnemy(i).MoveBy(100000, 0);
        end;
    end;
    
    procedure RoadMove();
    begin
      for var i := 0 to 1 do
      begin
        Road[i].MoveBy(0, speed_road);
        if Road[i].Top >= Window.Height then Road[i].MoveTo(0, -Window.Height + 10);
      end;
    end;
    
    
    public Enemy := Enemys.Create;
    public GameBreak := false;
  
  private
    Player: PictureWPF;
    Road := new PictureWPF[2];
    
    Heart := Healph.Create;
    
    score_healph := 3; // 1 2 3
    icon_healph := new PictureWPF[3];
    
    procedure AddHealph;
    begin
      for var i := 0 to Heart.Heart.Length - 1 do
        if (ObjectsIntersect(Heart.Heart[i], Player)) and (score_healph < 3) then
        begin
          icon_healph[score_healph].Destroy;
          icon_healph[score_healph] := PictureWPF.Create(score_healph * 30, 50, 'pictures\Healph.png');    
          score_healph += 1;
          Heart.Heart[i].MoveBy(100000, 0);
        end;
    end;
    
    procedure GameOver;
    begin
      var recors_stat := Statist.Create;
      recors_stat.Save_all(Enemy.score_speed.Text.ToReal);
      speed_road := 0.7;
      
      Player.Destroy;
      
      for var i := 0 to Enemy.value_enemy - 1 do
        Enemy.GetEnemy(i).Destroy;
      
      foreach var &e in Heart.Heart do
        E.Destroy;
      
      foreach var &e in Road do
        E.destroy;
      
      foreach var &E in icon_healph do E.Destroy;
      
      Enemy.score_speed.destroy;
      
      Window.Clear;
      
      GameBreak := true;
    end;
  end;

begin

end. 