unit Healths;

uses WPFObjects;

type
  Healph = class
    procedure CreateHeart;
    begin
      for var i := 0 to Heart.Length - 1 do
        Heart[i] := PictureWPF.Create(Random(140, 745), Random(-4000, -600), 'pictures\Heart.png');
    end;
    
    procedure HealphMove(speed: real);
    begin
      for var i := 0 to Heart.Length - 1 do
      begin
        Heart[i].MoveBy(0, speed - speed / 1.5);
        if Heart[i].Top > Window.Height then
          Heart[i].MoveTo(Random(140, 745), Random(-5000, -2000));
      end;
    end;
    
    public Heart := new PictureWPF[2];
  end;
end.