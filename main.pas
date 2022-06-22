uses GraphWPF,WPFObjects,События,Меню;
label Restart_game;

begin
Restart_game:

Window.SetSize(1000,1000);
Window.Clear(Colors.Black);
Window.Caption := 'Бешеная дорога';
Window.CenterOnScreen;
//Window.IsFixedSize := true; // ломается дорога


var lobby := Menu.Create;
lobby.DrawMenu;
  OnMouseDown := lobby.MenuMouseDown;

while lobby.start_check do;



var Rules := events.Create;
  Rules.CreateLvL;
  Rules.Enemy.CreateEnemy(3);
  OnKeyDown := Rules.CarMove;
  OnMouseDown := nil;
  while not Rules.GameBreak do
   Rules.CheckRules;
  
  //var Restart := true;
  
 //lobby.DrawLastMenu(Restart); // Старт не работает
   goto Restart_game;
end.