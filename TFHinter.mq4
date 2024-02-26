//+------------------------------------------------------------------+
//|                                                     TFHinter.mq4 |
//|                                  Copyright 2024, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, MetaQuotes Ltd."
#property version   "0.1"
#property strict
//--- input parameters
input double   maxPips=7.0;
double oldSpread;
double currentSpread;
datetime closeTime = 0;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   ObjectCreate(0, "spreadLabel", OBJ_LABEL,0,0,0);
   ObjectSet("spreadLabel", OBJPROP_XDISTANCE, 984);
   ObjectSet("spreadLabel", OBJPROP_YDISTANCE, 9);
   ObjectCreate(0, "oldSpread", OBJ_LABEL,0,0,0);
   ObjectSet("oldSpread", OBJPROP_XDISTANCE, 984);
   ObjectSet("oldSpread", OBJPROP_YDISTANCE, 29);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }//2024.02.26 18:02:59.945	TFHinter USDCHF,M1: 1708974120
//  2024.02.26 18:02:59.945	TFHinter USDCHF,M1: 1708974120


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   closeTime = Time[0]+Period();
   currentSpread = MarketInfo(Symbol(), MODE_SPREAD);
   ObjectSetText("spreadLabel","Current Tick Spread: " + currentSpread, 10, "Arial", clrWhite);
   if(closeTime < TimeCurrent())
     {
      printf("CurrentCandle: "+TimeToString(closeTime));
      if(currentSpread >= maxPips && currentSpread > oldSpread)
        {
         oldSpread=currentSpread;

        }

     }
     else{
         if(currentSpread >= maxPips)
         {
             CreateDot(1.2);
             oldSpread = 0;
             printf(Time[1]);
         
         }
         
     }

   ObjectSetText("oldSpread","Highest Tick Spread: " + oldSpread, 10, "Arial", clrWhite);
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam,const string &sparam)
  {
//---

  }
//+------------------------------------------------------------------+
void CreateDot(double price)
  {
   string dotName =  "Dot_Object_" + IntegerToString(Time[0]);
   int dotType = OBJ_CYCLES; // Type of the object (you can change this)
   int dotSize = 5; // Size of the dot
   color dotColor = clrRed; // Color of the dot (you can change this)

   //--- Create the dot object
   ObjectCreate(dotName, dotType, 0, Time[1], price);
   ObjectSet(dotName, OBJPROP_SELECTABLE, false);
   ObjectSet(dotName, OBJPROP_COLOR, dotColor);
   ObjectSet(dotName, OBJPROP_WIDTH, dotSize);
  }