-- A skeleton of an ADA program for an assignment in programming languages

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Characters.Latin_1; use Ada.Characters.Latin_1;
with Ada.Integer_Text_IO;
with Ada.Numerics.Discrete_Random;


procedure Simulation is

   ----GLOBAL VARIABLES---

   Number_Of_Producers: constant Integer := 6;
   Number_Of_Assemblies: constant Integer := 3;
   Number_Of_Consumers: constant Integer := 2;

   subtype Producer_Type is Integer range 1 .. Number_Of_Producers;
   subtype Assembly_Type is Integer range 1 .. Number_Of_Assemblies;
   subtype Consumer_Type is Integer range 1 .. Number_Of_Consumers;


   --each Producer is assigned a Product that it produces
   Product_Name: constant array (Producer_Type) of String(1 .. 11)
     := ("Bowl       ", "Toy        ", "Bed        ", "HamsterFood", "CatFood    ","BagOfLitter");
   --Assembly is a collection of products
   Assembly_Name: constant array (Assembly_Type) of String(1 .. 10)
     := ("CatKit    ", "DogKit    ", "HamsterKit");


   ----TASK DECLARATIONS----

   -- Producer produces determined product
   task type Producer is
      entry Start(Product: in Producer_Type; Production_Time: in Integer);
   end Producer;

   -- Consumer gets an arbitrary assembly of several products from the buffer
   -- but he/she orders it randomly
   task type Consumer is
      entry Start(Consumer_Number: in Consumer_Type;
                  Consumption_Time: in Integer);
   end Consumer;

   -- Buffer receives products from Producers and delivers Assemblies to Consumers
   task type Buffer is
      -- Accept a product to the storage (provided there is a room for it)
      entry Take(Product: in Producer_Type; Number: in Integer; Stop_Production: in out Boolean);
      -- Deliver an assembly (provided there are enough products for it)
      entry Deliver(Assembly: in Assembly_Type; Number: out Integer);
      entry Pest_In_Storage;
   end Buffer;

   task type Pest is
      entry Start;
   end Pest;
   
   P: array ( 1 .. Number_Of_Producers ) of Producer;
   K: array ( 1 .. Number_Of_Consumers ) of Consumer;
   B: Buffer;
   PE: Pest;

   ----TASK DEFINITIONS----

   --Producer--

   task body Producer is
      subtype Production_Time_Range is Integer range 1 .. 3;
      package Random_Production is new Ada.Numerics.Discrete_Random(Production_Time_Range);
      --  random number generator
      G: Random_Production.Generator;
      Producer_Type_Number: Integer;
      Product_Number: Integer;
      Production: Integer;
      Random_Time: Duration;
      Stop_Production: Boolean := False;
   begin
      accept Start(Product: in Producer_Type; Production_Time: in Integer) do
         --  start random number generator
         Random_Production.Reset(G);
         Product_Number := 1;
         Producer_Type_Number := Product;
         Production := Production_Time;
      end Start;
      Put_Line(ESC & "[93m" & "P: Started producer of " & Product_Name(Producer_Type_Number) & ESC & "[0m");
      loop
         Random_Time := Duration(Random_Production.Random(G));
         delay Random_Time;
         
         if Stop_Production = False then
            Put_Line(ESC & "[93m" & "P: Produced " & Product_Name(Producer_Type_Number)
                  & " number "  & Integer'Image(Product_Number) & ESC & "[0m");
            
            B.Take(Producer_Type_Number, Product_Number, Stop_Production);
            Product_Number := Product_Number + 1;
         else
            delay 1.0; -- keep checking if the storage is full after a time delay
            B.Take(Producer_Type_Number, Product_Number, Stop_Production);
         end if;
      end loop;
   end Producer;


   --Consumer--

   task body Consumer is
      subtype Consumption_Time_Range is Integer range 4 .. 8;
      package Random_Consumption is new
        Ada.Numerics.Discrete_Random(Consumption_Time_Range);

      --each Consumer takes any (random) Assembly from the Buffer
      package Random_Assembly is new
        Ada.Numerics.Discrete_Random(Assembly_Type);
      
      -- when an order is rejected the consumer may try to order a product again after a random time interval
      subtype Retry_Interval is Integer range 1 .. 5;
      package Random_Interval is new Ada.Numerics.Discrete_Random(Retry_Interval);

      -- when an order is rejected the consumer has a chance to give up their order
      subtype Chance is Integer range 1 .. 100;
      package Random_Chance is new Ada.Numerics.Discrete_Random(Chance);
      
      G: Random_Consumption.Generator;
      GA: Random_Assembly.Generator;
      GRetInterval: Random_Interval.Generator;
      GGiveupTime: Random_Interval.Generator;
      Consumer_Nb: Consumer_Type;
      Assembly_Number: Integer;
      Consumption: Integer;
      Assembly_Type: Integer;
      Consumer_Name: constant array (1 .. Number_Of_Consumers)
        of String(1 .. 7)
        := ("Client1", "Client2");
      Giveup_Time : Duration := Duration(Random_Interval.Random(GRetInterval));
      Time_Interval : Duration := Duration(Random_Interval.Random(GRetInterval));
   begin
      accept Start(Consumer_Number: in Consumer_Type;
                   Consumption_Time: in Integer) do
         Random_Consumption.Reset(G);
         Random_Assembly.Reset(GA);
         Random_Interval.Reset(GRetInterval);
         Random_Interval.Reset(GGiveupTime);
         Consumer_Nb := Consumer_Number;
         Consumption := Consumption_Time;
      end Start;
      Put_Line(ESC & "[96m" & "C: Started client " & Consumer_Name(Consumer_Nb) & ESC & "[0m");
      loop
         delay Duration(Random_Consumption.Random(G)); --  simulate consumption
         Assembly_Type := Random_Assembly.Random(GA);
         -- take an assembly for consumption
         loop
            B.Deliver(Assembly_Type, Assembly_Number);
            if Assembly_Number /= 0 then
               Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & " received kit " &
                  Assembly_Name(Assembly_Type) & " number " &
                  Integer'Image(Assembly_Number) & ESC & "[0m");
               exit;
            else
               Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & "'s order of " &
                  Assembly_Name(Assembly_Type) & " was rejected." & ESC & "[0m");
               Time_Interval := Duration(Random_Interval.Random(GRetInterval));
               select 
                  delay Giveup_Time;
                  B.Deliver(Assembly_Type, Assembly_Number);
                  Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & 
                             " waits and tries ordering " & Assembly_Name(Assembly_Type) & " again. Kit number: "
                           & Integer'Image(Assembly_Number)& ESC & "[0m");
               then abort  
                  delay Time_Interval;
                  Put_Line(ESC & "[96m" & "C: " & Consumer_Name(Consumer_Nb) & " gave up on ordering " 
                     & Assembly_Name(Assembly_Type) & ESC & "[0m");
               end select;
      end if;
   end loop;
      end loop;
   end Consumer;


   --Buffer--

   task body Buffer is
      Storage_Capacity: constant Integer := 38;
      type Storage_type is array (Producer_Type) of Integer;
      Storage: Storage_type
        := (0, 0, 0, 0, 0, 0);
      Assembly_Content: array(Assembly_Type, Producer_Type) of Integer
        := ((2, 1, 1, 0, 1, 0),
            (2, 2, 1, 0, 0, 2),
            (1, 0, 0, 1, 0, 2));
      Max_Storage_For_Product:array (Producer_Type) of Integer := (11, 7, 5, 3, 3, 9);
      Max_Assembly_Content: array(Producer_Type) of Integer;
      Assembly_Number: array(Assembly_Type) of Integer
        := (1, 1, 1);
      In_Storage: Integer := 0;

      procedure Setup_Variables is
      begin
         for W in Producer_Type loop
            Max_Assembly_Content(W) := 0;
            for Z in Assembly_Type loop
               if Assembly_Content(Z, W) > Max_Assembly_Content(W) then
                  Max_Assembly_Content(W) := Assembly_Content(Z, W);
               end if;
            end loop;
         end loop;
      end Setup_Variables;

      function Can_Accept(Product: Producer_Type) return Boolean is
      begin
         if Storage(Product) >= Max_Storage_For_Product(Product) then
            return False;
         else
            return True;
         end if;
      end Can_Accept;

      function Can_Deliver(Assembly: Assembly_Type) return Boolean is
      begin
         for W in Producer_Type loop
            if Storage(W) < Assembly_Content(Assembly, W) then
               return False;
            end if;
         end loop;
         return True;
      end Can_Deliver;

      procedure Storage_Contents is
      begin
         for W in Producer_Type loop
            Put_Line("|   Storage contents: " & Integer'Image(Storage(W)) & " "
                     & Product_Name(W) & ", max: " & Integer'Image(Max_Storage_For_Product(W)));
         end loop;
      end Storage_Contents;
      
      procedure Product_Destruction is
         subtype Pest_Choices is Integer range 4 .. 5;
         package Random_Product is new Ada.Numerics.Discrete_Random(Pest_Choices);
         G: Random_Product.Generator;
         Random_Index : Pest_Choices;
         Pest_Allowed_Products : constant array(Pest_Choices) of Producer_Type := (4, 5);
         Product: Producer_Type;
      begin
         Random_Product.Reset(G);
         Random_Index := Random_Product.Random(G);
         Product := Pest_Allowed_Products(Random_Index);
         Put_Line(ESC & "[35m" & "PEST ENTERED: this pest likes product " &
                    Product_Name(Product) & " and will eat it" & ESC & "[0m");
         if Storage(Product) > 0 then
            Storage(Product) := 0;
            Put_Line(ESC & "[35m" & "PEST RESULT: you have lost all stock of product " &
                       Product_Name(Product) & ESC & "[0m");
         else
            Put_Line(ESC & "[35m" & "PEST RESULT: there was nothing for the pest to eat- " &
                       Product_Name(Product) &"stock was already empty" & ESC & "[0m");
         end if;
      end Product_Destruction;

   begin
      Put_Line(ESC & "[91m" & "B: Buffer started" & ESC & "[0m");
      Setup_Variables;
      loop
         select 
            accept Take(Product: in Producer_Type; Number: in Integer; Stop_Production: in out Boolean) do
               if Can_Accept(Product) then
                  if Stop_Production=False then
                     Put_Line(ESC & "[91m" & "B: Accepted product " & Product_Name(Product) & " number " &
                          Integer'Image(Number)& ESC & "[0m");
                     Storage(Product) := Storage(Product) + 1;
                  else
                     Put_Line(ESC & "[91m" & "B: Production of " & Product_Name(Product) & " is now resumed." & ESC & "[0m");
                     Stop_Production:=False;
                  end if;
               else
                  if Stop_Production=False then 
                     Put_Line(ESC & "[91m" & "B: Rejected product " & Product_Name(Product) & " number " &
                                Integer'Image(Number) & ". Its production will stop until there is enough space in buffer for it"& ESC & "[0m");
                     Stop_Production:=True;
                  end if;
               end if;
            end Take;
            Storage_Contents;
         or
            accept Deliver(Assembly: in Assembly_Type; Number: out Integer) do
               if Can_Deliver(Assembly) then
                  Put_Line(ESC & "[96m" & "B: Accepted order: kit " & Assembly_Name(Assembly) & " number " &
                          Integer'Image(Assembly_Number(Assembly))& ESC & "[0m");
                  for W in Producer_Type loop
                     Storage(W) := Storage(W) - Assembly_Content(Assembly, W);
                  end loop;
                  Number := Assembly_Number(Assembly);
                  Assembly_Number(Assembly) := Assembly_Number(Assembly) + 1;
               else
                  Put_Line(ESC & "[96m" & "B: Order rejected - lacking products for kit " & Assembly_Name(Assembly)& ESC & "[0m");
                  Number := 0;
               end if;
            end Deliver;
            Storage_Contents;
         or
            accept Pest_In_Storage do
               Product_destruction;
            end Pest_In_Storage;
            Storage_Contents;
         end select;
      end loop;
   end Buffer;
   task body Pest is
      subtype Pest_Time_Range is Integer range 10 .. 30;
      package Random_Pest is new Ada.Numerics.Discrete_Random(Pest_Time_Range);
      --  random number generator
      G: Random_Pest.Generator;
      Random_Time: Duration;
   begin
      accept Start do
         --  start random number generator
         Random_Pest.Reset(G);
      end Start;
      Put_Line(ESC & "[35m" & "PEST: Pest started." & ESC & "[0m");
      loop
         Random_Time := Duration(Random_Pest.Random(G));
         delay Random_Time;
          B.Pest_In_Storage;
      end loop;
   end Pest;
   ---"MAIN" FOR SIMULATION---
begin
   for I in 1 .. Number_Of_Producers loop
      P(I).Start(I, 10);
   end loop;
   for J in 1 .. Number_Of_Consumers loop
      K(J).Start(J,12);
   end loop;
   PE.Start;
end Simulation;

