//+------------------------------------------------------------------+
//|                 MADINA AI TRADER PRO v5                          |
//|           Professional oltin savdo tizimi                        |
//|                     Created by Madina                            |
//+------------------------------------------------------------------+
#property copyright "Madina AI Trader PRO"
#property version   "5.00"
#property strict

#include <Trade/Trade.mqh>

CTrade trade;

//==============================================================
//               MONEY MANAGEMENT (UZBEK)
//==============================================================

input group "💰 PUL BOSHQARUVI"

input bool   UseFixedLot      = false;     // Doimiy lot ishlatish
input bool   UseRiskPercent   = true;      // Balans foizi bo'yicha lot
input bool   UseAutoLot       = false;     // Avtomatik lot
input bool   UseAIDynamicLot  = false;   // AI Dinamik Lot

input double FixedLot         = 0.01;      // Doimiy lot
input double RiskPercent      = 2.0;       // Har bir savdoda risk (%)
input double MaxRiskPercent   = 3.0;       // Bitta savdo uchun maksimal risk (%)
input double AutoLotStep      = 1000.0;    // Har 1000$ uchun lot

input double MinLot           = 0.01;      // Minimal lot
input double MaxLot           = 50.0;      // Maksimal lot

//==============================================================
//                 TREND SOZLAMALARI
//==============================================================

input group "📈 TREND FILTRI"

input int FastEMA             = 20;        // Tez EMA
input int SlowEMA             = 50;        // O'rta EMA
input int TrendEMA            = 200;       // Asosiy trend EMA

input int ADXPeriod           = 14;        // ADX davri
input int RSIPeriod           = 14;        // RSI davri
input double BuyRSIMin        = 52.0;      // Xarid uchun minimal RSI
input double SellRSIMax       = 48.0;      // Sotish uchun maksimal RSI
input int StructureLookback   = 20;        // BOS/CHOCH tahlil shamlari
input double MinAIScore       = 70.0;      // Minimal AI baho
input double MinSMCScore      = 35.0;      // Minimal SMC baho
input double MinADX           = 22.0;      // Minimal trend kuchi

//==============================================================
//                  VOLATILITY
//==============================================================

input group "📊 ATR FILTRI"

input int ATRPeriod           = 14;        // ATR davri
input double StopLossATR      = 2.0;       // StopLoss ATR
input double TakeProfitATR    = 3.0;       // TakeProfit ATR
input double BreakEvenATR     = 1.0;       // BreakEven
input double BreakEvenLockATR = 0.10;      // BreakEven foydani qulflash ATR
input double TrailATR         = 1.5;       // Trailing Stop
input double TrailStartATR    = 1.2;       // Trailing boshlanish ATR
input double TrailStepATR     = 0.25;      // Trailing minimal qadam ATR
input double MinATRPoints     = 50.0;      // Minimal ATR (punkt)
input double MaxATRPoints     = 5000.0;    // Maksimal ATR (punkt)

//==============================================================
//                   SAVDO
//==============================================================

input group "⚙ SAVDO"

input int MaxSpread           = 25;        // Maksimal spred
input int BreakoutBars        = 10;        // Breakout shamlari
input bool UseSessionFilter   = true;      // Sessiya filtri
input int StartHour           = 8;         // Boshlanish vaqti
input int EndHour             = 22;        // Tugash vaqti
input int FridayCloseHour     = 20;        // Juma kuni savdoni toxtatish
input int MinBarsBetweenTrades= 1;         // Savdolar orasidagi shamlar

input ulong Magic             = 2026001;   // Robot ID
//==============================================================
//                 XAVFSIZLIK
//==============================================================

input group "🛡 HIMOYA"

input bool   UseDailyLossStop = true;      // Kunlik limit
input double MaxDailyLoss      = 5.0;      // Maksimal kunlik zarar %
input bool   UseDailyProfitStop= true;     // Kunlik foyda limiti
input double MaxDailyProfit    = 8.0;      // Maksimal kunlik foyda %
input bool   UseEquityProtect  = true;     // Equity himoyasi
input double MinEquityPercent  = 80.0;     // Minimal equity (% balansdan)
input bool   UseSafeMode       = true;     // Xavfsiz rejim
input bool   UseSelfLearning   = true;     // Ozi organish filtri
input bool   UseAutoOptimizer  = true;     // Avto optimizator
input int    OptimizerLookback = 30;       // Optimizator xotira chuqurligi
input double MaxLotDDCut       = 10.0;     // Drawdown lot kamaytirish boshlanishi %

input bool   UseDrawdownStop   = true;     // Drawdown nazorati
input double MaxDrawdown       = 20.0;     // Maksimal Drawdown %

input bool   UseNewsFilter     = false;    // Yangilik filtri
input int    NewsMinutesBefore = 30;       // Yangilikdan oldin kutish (min)
input int    NewsMinutesAfter  = 30;       // Yangilikdan keyin kutish (min)
input string ManualNewsTimes   = "";       // Format: YYYY.MM.DD HH:MI;YYYY.MM.DD HH:MI
input bool   UseSpreadFilter   = true;     // Spred filtri
input bool   UseHTFFilter      = true;     // H1 trend filtri
input ENUM_TIMEFRAMES HigherTF = PERIOD_H1;// Yuqori timeframe
input ENUM_TIMEFRAMES MiddleTF = PERIOD_M15;// O'rta timeframe
input bool   UseATRFilter      = true;     // ATR filtri
input bool   UseADXFilter      = true;     // ADX filtri
input bool   UseVolumeFilter   = false;    // Hajm filtri
input bool   UseFlatFilter     = true;     // Flat filtri

//==============================================================
//                  CHIQISH
//==============================================================

input group "📦 POZITSIYANI BOSHQARISH"

input bool UseBreakEven      = true;       // BreakEven
input bool UseTrailing       = true;       // Trailing Stop
input bool UsePartialClose   = true;       // Qisman yopish

input double PartialPercent  = 50.0;       // Qancha yopiladi
input double PartialATR      = 2.0;        // ATR bo'yicha yopish

//==============================================================
//                     HUD
//==============================================================

input group "🖥 PANEL"

input bool ShowHUD          = true;        // Panelni ko'rsatish
input bool ShowSpread       = true;        // Spread
input bool ShowATR          = true;        // ATR
input bool ShowADX          = true;        // ADX
input bool ShowBalance      = true;        // Balans
input bool ShowProfit       = true;        // Foyda
input bool ShowWinRate      = true;        // Win Rate
input bool ShowTrend        = true;        // Trend
input bool ShowSignal       = true;        // Signal
input bool ShowSession      = true;        // Sessiya
input bool ShowNewsStatus   = true;        // Yangilik holati
input bool ShowSMCStatus    = true;        // SMC holati

//==============================================================
//               GLOBAL O'ZGARUVCHILAR
//==============================================================

int FastEMAHandle;
int SlowEMAHandle;
int TrendEMAHandle;
//==============================================================
//              HIGHER TIMEFRAME
//==============================================================

int FastEMA_H1_Handle;
int SlowEMA_H1_Handle;

int FastEMA_M15_Handle;
int SlowEMA_M15_Handle;

int ATRHandle;
int ADXHandle;
int RSIHandle;

datetime LastTradeBar = 0;
datetime LastPositionManage = 0;
string LastBlockReason = "Yuklanmoqda";

double FastEMAValue[];
double SlowEMAValue[];
double TrendEMAValue[];
double FastEMA_H1[];
double SlowEMA_H1[];

double FastEMA_M15[];
double SlowEMA_M15[];
double ATRValue[];
double ADXValue[];
double RSIValue[];

double PlusDI[];
double MinusDI[];

//==============================================================
//              MODUL PROTOTIPLARI
//==============================================================

bool RiskLimitsOK();
double CalculateLot(double StopDistance);
bool HTFTrendBuy();
bool HTFTrendSell();
bool NewsOK();
bool BuySignal();
bool SellSignal();
string EntryBlockReason(bool buy);
void ManageOpenPosition();
void DrawHUD();
void DrawPanel();

//==============================================================
//              MODULLI ARXITEKTURA QATLAMI
//==============================================================

class Logger
{
public:
   void Info(string message) { Print("MADINA: "+message); }
};

class RiskManager
{
public:
   bool CanTrade() { return RiskLimitsOK(); }
   double Lot(double stop_distance) { return CalculateLot(stop_distance); }
};

class TrendFilter
{
public:
   bool Buy() { return HTFTrendBuy(); }
   bool Sell() { return HTFTrendSell(); }
};

class NewsFilter
{
public:
   bool CanTrade() { return NewsOK(); }
};

class EntryManager
{
public:
   bool Buy() { return BuySignal(); }
   bool Sell() { return SellSignal(); }
};

class ExitManager
{
public:
   void Manage() { ManageOpenPosition(); }
};

class Dashboard
{
public:
   void Render() { DrawHUD(); DrawPanel(); }
};

Logger AppLogger;
RiskManager AppRisk;
TrendFilter AppTrend;
NewsFilter AppNews;
EntryManager AppEntry;
ExitManager AppExit;
Dashboard AppDashboard;

//==============================================================
//                 Ask / Bid
//==============================================================

double AskPrice()
{
   return SymbolInfoDouble(_Symbol, SYMBOL_ASK);
}

double BidPrice()
{
   return SymbolInfoDouble(_Symbol, SYMBOL_BID);
}

//==============================================================
//             Ochiq pozitsiyani tekshirish
//==============================================================

bool PositionOpened()
{
   if(!PositionSelect(_Symbol))
      return false;

   return ((ulong)PositionGetInteger(POSITION_MAGIC)==Magic);
}

//==============================================================
//               Spredni tekshirish
//==============================================================

bool SpreadOK()
{
   if(!UseSpreadFilter)
      return true;

   double spread=(AskPrice()-BidPrice())/_Point;

   if(spread>MaxSpread)
      return false;

   return true;
}

//==============================================================
//             Oxirgi shamlarning maksimumi
//==============================================================

double HighestHighFrom(int bars,int start)
{
   int index=iHighest(_Symbol,_Period,MODE_HIGH,bars,start);
   if(index<0)
      return 0.0;

   return iHigh(_Symbol,_Period,index);
}

double HighestHigh(int bars)
{
   return HighestHighFrom(bars,1);
}

//==============================================================
//              Oxirgi shamlarning minimumi
//==============================================================

double LowestLowFrom(int bars,int start)
{
   int index=iLowest(_Symbol,_Period,MODE_LOW,bars,start);
   if(index<0)
      return 0.0;

   return iLow(_Symbol,_Period,index);
}

double LowestLow(int bars)
{
   return LowestLowFrom(bars,1);
}

//==============================================================
//                Joriy balans
//==============================================================

double Balance()
{
   return AccountInfoDouble(ACCOUNT_BALANCE);
}

//==============================================================
//                Joriy equity
//==============================================================

double Equity()
{
   return AccountInfoDouble(ACCOUNT_EQUITY);
}

//==============================================================
//                 Joriy foyda
//==============================================================

double Profit()
{
   return AccountInfoDouble(ACCOUNT_PROFIT);
}
//==============================================================
//              PROFESSIONAL LOT HISOBLAGICH
//==============================================================

double CalculateLot(double StopDistance)
{
//----------------------------------------------------------
// AI DYNAMIC LOT
//----------------------------------------------------------

if(UseAIDynamicLot)
{
   double lot = Balance() * RiskPercent / 100.0;

   lot /= 100.0;

   //-----------------------------
   // AI BAHO
   //-----------------------------

   double score = GetAIScore();

   //-----------------------------
   // TREND
   //-----------------------------

   double trend = GetTrendStrength();

   //-----------------------------
   // SCORE
   //-----------------------------

   if(score>=95)
      lot*=1.50;

   else if(score>=90)
      lot*=1.30;

   else if(score>=80)
      lot*=1.10;

   else if(score>=70)
      lot*=0.80;

   else
      return 0;

   //-----------------------------
   // TREND BONUS
   //-----------------------------

   if(trend>=80)
      lot*=1.20;

   else if(trend<40)
      lot*=0.70;

   //-----------------------------
   // FOYDA SERIYASI
   //-----------------------------

   if(WinSeries>=3)
      lot*=1.15;

   //-----------------------------
   // ZARAR SERIYASI
   //-----------------------------

   if(LossSeries>=2)
      lot*=0.60;

   //-----------------------------
   // AI REJIM
   //-----------------------------

   lot*=GetRiskMultiplier();

   lot*=DrawdownLotMultiplier();

   return NormalizeLot(lot);
}

   //----------------------------------------------------------
   // FIXED LOT
   //----------------------------------------------------------

   if(UseFixedLot)
      return NormalizeLot(FixedLot);

   //----------------------------------------------------------
   // AUTO LOT
   //----------------------------------------------------------

   if(UseAutoLot)
   {
      double lot = Balance() / AutoLotStep * 0.01;

      lot*=DrawdownLotMultiplier();
      return NormalizeLot(lot);
   }

   //----------------------------------------------------------
   // RISK %
   //----------------------------------------------------------

   if(UseRiskPercent)
   {
      double EffectiveRisk = MathMin(RiskPercent,MaxRiskPercent);
      double RiskMoney = Equity() * EffectiveRisk * GetRiskMultiplier() * OptimizedRiskMultiplier() * DrawdownLotMultiplier() / 100.0;

      double TickValue = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_VALUE);

      double TickSize  = SymbolInfoDouble(_Symbol,SYMBOL_TRADE_TICK_SIZE);

      if(TickValue<=0 || TickSize<=0 || StopDistance<=0)
         return 0.0;

      double lot =
      RiskMoney /
      ((StopDistance/TickSize)*TickValue);

      return NormalizeLot(lot);
   }

   return NormalizeLot(FixedLot);
}

double NormalizeLot(double lot)
{
   double symbolMin=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double symbolMax=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MAX);
   double step=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_STEP);

   double minAllowed=MathMax(MinLot,symbolMin);
   double maxAllowed=MathMin(MaxLot,symbolMax);

   if(lot<minAllowed)
      lot=minAllowed;

   if(lot>maxAllowed)
      lot=maxAllowed;

   if(step>0)
      lot=MathFloor(lot/step)*step;

   if(lot<minAllowed)
      return 0.0;

   return NormalizeDouble(lot,2);
}

double DrawdownLotMultiplier()
{
   double dd=DrawdownPercent();
   if(dd<=MaxLotDDCut)
      return 1.0;

   if(MaxDrawdown<=MaxLotDDCut)
      return 0.50;

   double pressure=(dd-MaxLotDDCut)/(MaxDrawdown-MaxLotDDCut);
   double mult=1.0-pressure*0.60;
   return MathMax(0.25,MathMin(mult,1.0));
}
//==============================================================
//                 AI ADAPTIVE SYSTEM
//==============================================================

// Ketma-ket zararlar
int LossSeries = 0;

// Ketma-ket foydalar
int WinSeries = 0;

// Savdo rejimi
enum AI_MODE
{
   MODE_NORMAL,
   MODE_SAFE,
   MODE_RECOVERY,
   MODE_STOP
};

AI_MODE CurrentMode = MODE_NORMAL;

//==============================================================

void UpdateAIMode()
{

   //------------------------------
   // STOP
   //------------------------------

   if(LossSeries >= 6)
   {
      CurrentMode = MODE_STOP;
      return;
   }

   //------------------------------
   // RECOVERY
   //------------------------------

   if(LossSeries >= 4)
   {
      CurrentMode = MODE_RECOVERY;
      return;
   }

   //------------------------------
   // SAFE
   //------------------------------

   if(LossSeries >= 2)
   {
      CurrentMode = MODE_SAFE;
      return;
   }

   //------------------------------
   // NORMAL
   //------------------------------

   CurrentMode = MODE_NORMAL;

}
//==============================================================
//                  AI MEMORY
//==============================================================

#define MEMORY_SIZE 100

struct TradeMemory
{
   datetime Time;
   bool Buy;
   double Profit;

   double ATR;
   double ADX;

   double Confidence;

   double BuyPower;
   double SellPower;
};

TradeMemory Memory[MEMORY_SIZE];

int MemoryIndex = 0;
//==============================================================
//          AI dinamik risk
//==============================================================

double GetRiskMultiplier()
{

   switch(CurrentMode)
   {

      case MODE_NORMAL:

         return 1.0;

      case MODE_SAFE:

         return 0.60;

      case MODE_RECOVERY:

         return 0.35;

      case MODE_STOP:

         return 0.0;

   }

   return 1.0;

}
//==============================================================
//          AI REJIM NAME
//==============================================================

string ModeName()
{

   switch(CurrentMode)
   {

      case MODE_NORMAL:

         return "ODDIY";

      case MODE_SAFE:

         return "XAVFSIZ";

      case MODE_RECOVERY:

         return "TIKLANISH";

      case MODE_STOP:

         return "TOXTASH";

   }

   return "NOMALUM";

}
//==============================================================
//              AQLLI BELGI ANIQLAGICH
//==============================================================

string GOLD="";
string SILVER="";
string EUR="";
string JPY="";
string BTC="";
string OIL="";
string DXY="";
string VIX="";
string SP500="";
string NASDAQ="";
string US10Y="";

//==============================================================

string FindSymbol(string &Names[])
{
   int total=SymbolsTotal(false);

   for(int i=0;i<total;i++)
   {
      string sym=SymbolName(i,false);

      for(int j=0;j<ArraySize(Names);j++)
      {
         if(StringFind(sym,Names[j])>=0)
            return sym;
      }
   }

   return "";
}
//==============================================================
//          BARCHA BELGILARNI QIDIRISH
//==============================================================

void DetectMarkets()
{

string GoldNames[]=
{
"XAUUSD",
"GOLD",
"XAUUSDm",
"XAUUSD.",
"XAUUSD.a"
};

string SilverNames[]=
{
"XAGUSD",
"SILVER",
"XAGUSDm"
};

string EurNames[]=
{
"EURUSD",
"EURUSDm"
};

string JpyNames[]=
{
"USDJPY",
"USDJPYm"
};

string BTCNames[]=
{
"BTCUSD",
"BTCUSDT",
"BTCUSDm"
};

string OilNames[]=
{
"USOIL",
"WTI",
"WTICOUSD",
"USOilCash",
"BRENT"
};

string DXYNames[]=
{
"DXY",
"USDX"
};

string VIXNames[]=
{
"VIX",
"VOLX"
};

string SPNames[]=
{
"SP500",
"US500",
"SPX500"
};

string NasdaqNames[]=
{
"NAS100",
"NASDAQ",
"USTEC"
};

string BondNames[]=
{
"US10Y",
"US10YR",
"TNX"
};

GOLD=FindSymbol(GoldNames);
SILVER=FindSymbol(SilverNames);
EUR=FindSymbol(EurNames);
JPY=FindSymbol(JpyNames);
BTC=FindSymbol(BTCNames);
OIL=FindSymbol(OilNames);
DXY=FindSymbol(DXYNames);
VIX=FindSymbol(VIXNames);
SP500=FindSymbol(SPNames);
NASDAQ=FindSymbol(NasdaqNames);
US10Y=FindSymbol(BondNames);

}
//==============================================================
//               BELGINI TANLASH
//==============================================================

void SelectSymbol(string sym)
{

   if(sym=="")
      return;

   SymbolSelect(sym,true);

}

//==============================================================
//          BARCHA BOZORLARNI FAOLLASHTIRISH
//==============================================================

void ActivateMarkets()
{

   SelectSymbol(GOLD);
   SelectSymbol(SILVER);
   SelectSymbol(EUR);
   SelectSymbol(JPY);
   SelectSymbol(BTC);
   SelectSymbol(OIL);
   SelectSymbol(DXY);
   SelectSymbol(VIX);
   SelectSymbol(SP500);
   SelectSymbol(NASDAQ);
   SelectSymbol(US10Y);

}
//==============================================================
//              BOZOR TRENDI
//==============================================================

int TrendDirection(string symbol)
{
   if(symbol=="")
      return 0;

   int EMA20Handle=iMA(symbol,PERIOD_H1,20,0,MODE_EMA,PRICE_CLOSE);
   int EMA50Handle=iMA(symbol,PERIOD_H1,50,0,MODE_EMA,PRICE_CLOSE);

   if(EMA20Handle==INVALID_HANDLE || EMA50Handle==INVALID_HANDLE)
      return 0;

   double ema20[];
   double ema50[];

   ArraySetAsSeries(ema20,true);
   ArraySetAsSeries(ema50,true);

   if(CopyBuffer(EMA20Handle,0,0,1,ema20)<=0)
   {
      IndicatorRelease(EMA20Handle);
      IndicatorRelease(EMA50Handle);
      return 0;
   }

   if(CopyBuffer(EMA50Handle,0,0,1,ema50)<=0)
   {
      IndicatorRelease(EMA20Handle);
      IndicatorRelease(EMA50Handle);
      return 0;
   }

   IndicatorRelease(EMA20Handle);
   IndicatorRelease(EMA50Handle);

   if(ema20[0] > ema50[0])
      return 1;

   if(ema20[0] < ema50[0])
      return -1;

   return 0;
}

//==============================================================
//          AI BOZOR BAHOSI
//==============================================================

int GetMarketScore()
{

   int score=0;

   if(TrendDirection(GOLD)==1)
      score++;

   if(TrendDirection(SILVER)==1)
      score++;

   if(TrendDirection(EUR)==1)
      score++;

   if(TrendDirection(BTC)==1)
      score++;

   if(TrendDirection(NASDAQ)==1)
      score++;

   if(TrendDirection(SP500)==1)
      score++;

   if(TrendDirection(OIL)==1)
      score++;

   if(TrendDirection(DXY)==-1)
      score++;

   return score;

}
//==============================================================
//          AI ISHONCH
//==============================================================

double GetConfidence()
{
   int score = GetMarketScore();

   return (score * 100.0) / 8.0;
}
//==============================================================
//              XARID / SOTISH KUCHI
//==============================================================

double GetBuyPower()
{
   double power = 0;

   if(FastEMAValue[0] > SlowEMAValue[0])
      power += 25;

   if(SlowEMAValue[0] > TrendEMAValue[0])
      power += 25;

   if(ADXValue[0] > MinADX)
      power += 25;

   power += GetConfidence() * 0.25;

   if(power > 100)
      power = 100;

   return power;
}

//==============================================================

double GetSellPower()
{
   double power = 0;

   if(FastEMAValue[0] < SlowEMAValue[0])
      power += 25;

   if(SlowEMAValue[0] < TrendEMAValue[0])
      power += 25;

   if(ADXValue[0] > MinADX)
      power += 25;

   power += (100 - GetConfidence()) * 0.25;

   if(power > 100)
      power = 100;

   return power;
}
//==============================================================
//              AI EHTIMOLI
//==============================================================

double GetBuyProbability()
{
   double probability = 0;

   probability += GetBuyPower() * 0.40;

   probability += GetConfidence() * 0.40;

   if(ADXValue[0] > MinADX)
      probability += 20;

   if(probability > 100)
      probability = 100;

   return probability;
}
//==============================================================
//                  AI BAHO 2.0
//==============================================================

double GetAIScore()
{
   double score = 0;

   score += GetBuyPower() * 0.35;

   score += GetConfidence() * 0.35;
   score += GetLearningBonus();
   score += GetTrendStrength() * 0.10;
   score += GetMarketIntelligence() * 0.20;

   if(ADXValue[0] >= MinADX)
      score += 15;

   if(ATRValue[0] > 0)
      score += 10;

   if(SpreadOK())
      score += 5;
      double MemoryRate = GetMemoryWinRate();

if(MemoryRate > 70)
   score += 5;

if(MemoryRate < 40)
   score -= 5;

   if(score > 100)
      score = 100;

   return score;
}

//==============================================================

double GetSellProbability()
{
   double probability = 0;

   probability += GetSellPower() * 0.40;

   probability += (100 - GetConfidence()) * 0.40;

   if(ADXValue[0] > MinADX)
      probability += 20;

   if(probability > 100)
      probability = 100;

   return probability;
}
//==============================================================
//                KIRISH SIFATI
//==============================================================

string GetEntryQuality()
{
   double score = GetAIScore();

   if(score >= 90)
      return "ALO";

   if(score >= 80)
      return "JUDA YAXSHI";

   if(score >= 70)
      return "YAXSHI";

   if(score >= 60)
      return "ODDIY";

   return "KUTISH";
}
//==============================================================
//          AI XARID FILTRI
//==============================================================

bool AIAllowBuy()
{

   if(GetConfidence()>=75)
      return true;

   return false;

}

//==============================================================
//          AI SOTISH FILTRI
//==============================================================

bool AIAllowSell()
{

   if(GetConfidence()<=25)
      return true;

   return false;

}
//==============================================================
//                      ISHGA TUSHIRISH
//==============================================================

int OnInit()
{
   trade.SetExpertMagicNumber(Magic);

   DetectMarkets();
   ActivateMarkets();

   FastEMAHandle = iMA(_Symbol,_Period,FastEMA,0,MODE_EMA,PRICE_CLOSE);
   SlowEMAHandle = iMA(_Symbol,_Period,SlowEMA,0,MODE_EMA,PRICE_CLOSE);
   TrendEMAHandle = iMA(_Symbol,_Period,TrendEMA,0,MODE_EMA,PRICE_CLOSE);

   ATRHandle = iATR(_Symbol,_Period,ATRPeriod);
   ADXHandle = iADX(_Symbol,_Period,ADXPeriod);
   RSIHandle = iRSI(_Symbol,_Period,RSIPeriod,PRICE_CLOSE);
   FastEMA_H1_Handle =
iMA(_Symbol,HigherTF,FastEMA,0,MODE_EMA,PRICE_CLOSE);

SlowEMA_H1_Handle =
iMA(_Symbol,HigherTF,SlowEMA,0,MODE_EMA,PRICE_CLOSE);

FastEMA_M15_Handle =
iMA(_Symbol,MiddleTF,FastEMA,0,MODE_EMA,PRICE_CLOSE);

SlowEMA_M15_Handle =
iMA(_Symbol,MiddleTF,SlowEMA,0,MODE_EMA,PRICE_CLOSE);

   if(FastEMAHandle==INVALID_HANDLE ||
      SlowEMAHandle==INVALID_HANDLE ||
      TrendEMAHandle==INVALID_HANDLE ||
      ATRHandle==INVALID_HANDLE ||
      ADXHandle==INVALID_HANDLE ||
      RSIHandle==INVALID_HANDLE ||
      FastEMA_H1_Handle==INVALID_HANDLE ||
      SlowEMA_H1_Handle==INVALID_HANDLE ||
      FastEMA_M15_Handle==INVALID_HANDLE ||
      SlowEMA_M15_Handle==INVALID_HANDLE)
   {
      AppLogger.Info("Indikator xatosi");
      return(INIT_FAILED);
   }

   ArraySetAsSeries(FastEMAValue,true);
   ArraySetAsSeries(SlowEMAValue,true);
   ArraySetAsSeries(TrendEMAValue,true);
   ArraySetAsSeries(ATRValue,true);
   ArraySetAsSeries(ADXValue,true);
   ArraySetAsSeries(RSIValue,true);
   ArraySetAsSeries(FastEMA_H1,true);
ArraySetAsSeries(SlowEMA_H1,true);

ArraySetAsSeries(FastEMA_M15,true);
ArraySetAsSeries(SlowEMA_M15,true);
ArraySetAsSeries(PlusDI,true);
ArraySetAsSeries(MinusDI,true);

   Print("=======================================");
   Print(" MADINA AI TRADER PRO v5 YUKLANDI ");
   Print(" AI REJIM = ",ModeName());
   Print(" GOLD = ",GOLD);
   Print(" SILVER = ",SILVER);
   Print(" BTC = ",BTC);
   Print(" DXY = ",DXY);
   Print("=======================================");

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason)
{
   IndicatorRelease(FastEMAHandle);
   IndicatorRelease(SlowEMAHandle);
   IndicatorRelease(TrendEMAHandle);
   IndicatorRelease(ATRHandle);
   IndicatorRelease(ADXHandle);
   IndicatorRelease(RSIHandle);
   IndicatorRelease(FastEMA_H1_Handle);
   IndicatorRelease(SlowEMA_H1_Handle);
   IndicatorRelease(FastEMA_M15_Handle);
   IndicatorRelease(SlowEMA_M15_Handle);
   Comment("");
}

//==============================================================
//                 PROFESSIONAL FILTRLAR VA IJRO
//==============================================================

double NormalizePrice(double price)
{
   return NormalizeDouble(price,(int)SymbolInfoInteger(_Symbol,SYMBOL_DIGITS));
}

bool RefreshIndicators()
{
   if(CopyBuffer(FastEMAHandle,0,0,3,FastEMAValue)<=0) return false;
   if(CopyBuffer(SlowEMAHandle,0,0,3,SlowEMAValue)<=0) return false;
   if(CopyBuffer(TrendEMAHandle,0,0,3,TrendEMAValue)<=0) return false;
   if(CopyBuffer(ATRHandle,0,0,2,ATRValue)<=0) return false;
   if(CopyBuffer(ADXHandle,0,0,2,ADXValue)<=0) return false;
   if(CopyBuffer(RSIHandle,0,0,2,RSIValue)<=0) return false;
   if(CopyBuffer(ADXHandle,1,0,2,PlusDI)<=0) return false;
   if(CopyBuffer(ADXHandle,2,0,2,MinusDI)<=0) return false;
   if(CopyBuffer(FastEMA_H1_Handle,0,0,2,FastEMA_H1)<=0) return false;
   if(CopyBuffer(SlowEMA_H1_Handle,0,0,2,SlowEMA_H1)<=0) return false;
   if(CopyBuffer(FastEMA_M15_Handle,0,0,2,FastEMA_M15)<=0) return false;
   if(CopyBuffer(SlowEMA_M15_Handle,0,0,2,SlowEMA_M15)<=0) return false;
   return true;
}

bool ATRFilterOK()
{
   if(!UseATRFilter)
      return true;

   double atrPoints=ATRValue[0]/_Point;
   return (atrPoints>=MinATRPoints && atrPoints<=MaxATRPoints);
}


bool VolumeFilterOK()
{
   if(!UseVolumeFilter)
      return true;

   long currentVolume=iVolume(_Symbol,_Period,1);
   if(currentVolume<=0)
      return false;

   long total=0;
   int samples=10;
   for(int i=2;i<2+samples;i++)
      total+=iVolume(_Symbol,_Period,i);

   if(total<=0)
      return true;

   double average=(double)total/samples;
   return (currentVolume>=average*0.80);
}

bool FlatFilterOK()
{
   if(!UseFlatFilter)
      return true;

   double emaDistance=MathAbs(FastEMAValue[0]-SlowEMAValue[0]);
   return (ATRValue[0]>0 && emaDistance>=ATRValue[0]*0.10);
}

bool SessionOK()
{
   if(!UseSessionFilter)
      return true;

   MqlDateTime tm;
   TimeToStruct(TimeCurrent(),tm);

   if(tm.day_of_week==0 || tm.day_of_week==6)
      return false;

   if(tm.day_of_week==5 && tm.hour>=FridayCloseHour)
      return false;

   if(StartHour==EndHour)
      return true;

   if(StartHour<EndHour)
      return (tm.hour>=StartHour && tm.hour<EndHour);

   return (tm.hour>=StartHour || tm.hour<EndHour);
}

bool NewsOK()
{
   if(!UseNewsFilter)
      return true;

   if(StringLen(ManualNewsTimes)==0)
      return true;

   string events[];
   int total=StringSplit(ManualNewsTimes,';',events);
   datetime now=TimeCurrent();

   for(int i=0;i<total;i++)
   {
      StringTrimLeft(events[i]);
      StringTrimRight(events[i]);
      datetime eventTime=StringToTime(events[i]);
      if(eventTime<=0)
         continue;

      if(now>=eventTime-NewsMinutesBefore*60 && now<=eventTime+NewsMinutesAfter*60)
         return false;
   }

   return true;
}


double TodayClosedProfit()
{
   MqlDateTime tm;
   TimeToStruct(TimeCurrent(),tm);
   tm.hour=0;
   tm.min=0;
   tm.sec=0;
   datetime dayStart=StructToTime(tm);

   double profit=0.0;
   if(!HistorySelect(dayStart,TimeCurrent()))
      return 0.0;

   int deals=HistoryDealsTotal();
   for(int i=0;i<deals;i++)
   {
      ulong ticket=HistoryDealGetTicket(i);
      if(ticket==0) continue;
      if(HistoryDealGetString(ticket,DEAL_SYMBOL)!=_Symbol) continue;
      if((ulong)HistoryDealGetInteger(ticket,DEAL_MAGIC)!=Magic) continue;
      profit+=HistoryDealGetDouble(ticket,DEAL_PROFIT)+HistoryDealGetDouble(ticket,DEAL_SWAP)+HistoryDealGetDouble(ticket,DEAL_COMMISSION);
   }

   return profit;
}

double DrawdownPercent()
{
   if(Balance()<=0)
      return 0.0;

   double dd=(Balance()-Equity())*100.0/Balance();
   return MathMax(dd,0.0);
}

string TrendText()
{
   if(FastEMAValue[0]>SlowEMAValue[0] && SlowEMAValue[0]>TrendEMAValue[0])
      return "Yuqoriga";

   if(FastEMAValue[0]<SlowEMAValue[0] && SlowEMAValue[0]<TrendEMAValue[0])
      return "Pastga";

   return "Noaniq";
}

string SessionText()
{
   return (SessionOK() ? "Ochiq" : "Yopiq");
}

string NewsText()
{
   if(!UseNewsFilter)
      return "Ochiq";

   return (NewsOK() ? "Xavfsiz" : "Yangilik vaqti");
}

bool RiskLimitsOK()
{
   if(UseDrawdownStop && Balance()>0)
   {
      double dd=(Balance()-Equity())*100.0/Balance();
      if(dd>=MaxDrawdown)
         return false;
   }

   if(UseDailyLossStop && Balance()>0)
   {
      MqlDateTime tm;
      TimeToStruct(TimeCurrent(),tm);
      tm.hour=0;
      tm.min=0;
      tm.sec=0;
      datetime dayStart=StructToTime(tm);

      if(HistorySelect(dayStart,TimeCurrent()))
      {
         double profit=0;
         int deals=HistoryDealsTotal();
         for(int i=0;i<deals;i++)
         {
            ulong ticket=HistoryDealGetTicket(i);
            if(ticket==0) continue;
            if(HistoryDealGetString(ticket,DEAL_SYMBOL)!=_Symbol) continue;
            if((ulong)HistoryDealGetInteger(ticket,DEAL_MAGIC)!=Magic) continue;
            profit+=HistoryDealGetDouble(ticket,DEAL_PROFIT)+HistoryDealGetDouble(ticket,DEAL_SWAP)+HistoryDealGetDouble(ticket,DEAL_COMMISSION);
         }

         if(profit<0 && MathAbs(profit)*100.0/Balance()>=MaxDailyLoss)
         {
            AppLogger.Info("Kunlik zarar limiti ishga tushdi");
            return false;
         }

         if(UseDailyProfitStop && profit>0 && profit*100.0/Balance()>=MaxDailyProfit)
         {
            AppLogger.Info("Kunlik foyda limiti bajarildi");
            return false;
         }
      }
   }

   if(UseEquityProtect && Balance()>0 && Equity()*100.0/Balance()<MinEquityPercent)
   {
      AppLogger.Info("Equity himoyasi savdoni toxtatdi");
      return false;
   }

   return true;
}

bool EnoughBarsAfterTrade()
{
   if(LastTradeBar==0)
      return true;

   int shift=iBarShift(_Symbol,_Period,LastTradeBar,true);
   return (shift<0 || shift>=MinBarsBetweenTrades);
}

bool HTFTrendBuy()
{
   if(!UseHTFFilter)
      return true;
   return (FastEMA_H1[0]>SlowEMA_H1[0] && FastEMA_M15[0]>SlowEMA_M15[0]);
}

bool HTFTrendSell()
{
   if(!UseHTFFilter)
      return true;
   return (FastEMA_H1[0]<SlowEMA_H1[0] && FastEMA_M15[0]<SlowEMA_M15[0]);
}


bool BullishDisplacement(int shift=1)
{
   double body=MathAbs(iClose(_Symbol,_Period,shift)-iOpen(_Symbol,_Period,shift));
   return (ATRValue[0]>0 && body>=ATRValue[0]*0.45 && iClose(_Symbol,_Period,shift)>iOpen(_Symbol,_Period,shift));
}

bool BearishDisplacement(int shift=1)
{
   double body=MathAbs(iClose(_Symbol,_Period,shift)-iOpen(_Symbol,_Period,shift));
   return (ATRValue[0]>0 && body>=ATRValue[0]*0.45 && iClose(_Symbol,_Period,shift)<iOpen(_Symbol,_Period,shift));
}

bool BullishBOS()
{
   double prevHigh=HighestHighFrom(StructureLookback,2);
   return (prevHigh>0 && iClose(_Symbol,_Period,1)>prevHigh && BullishDisplacement(1));
}

bool BearishBOS()
{
   double prevLow=LowestLowFrom(StructureLookback,2);
   return (prevLow>0 && iClose(_Symbol,_Period,1)<prevLow && BearishDisplacement(1));
}

bool BullishCHOCH()
{
   double prevHigh=HighestHighFrom(MathMax(5,StructureLookback/2),2);
   return ((FastEMAValue[1]<=SlowEMAValue[1] && FastEMAValue[0]>SlowEMAValue[0]) ||
           (prevHigh>0 && iClose(_Symbol,_Period,1)>prevHigh && PlusDI[0]>MinusDI[0]));
}

bool BearishCHOCH()
{
   double prevLow=LowestLowFrom(MathMax(5,StructureLookback/2),2);
   return ((FastEMAValue[1]>=SlowEMAValue[1] && FastEMAValue[0]<SlowEMAValue[0]) ||
           (prevLow>0 && iClose(_Symbol,_Period,1)<prevLow && MinusDI[0]>PlusDI[0]));
}

bool BullishFairValueGap()
{
   return (iLow(_Symbol,_Period,1)>iHigh(_Symbol,_Period,3));
}

bool BearishFairValueGap()
{
   return (iHigh(_Symbol,_Period,1)<iLow(_Symbol,_Period,3));
}

bool BullishOrderBlock()
{
   return (iClose(_Symbol,_Period,2)<iOpen(_Symbol,_Period,2) && iClose(_Symbol,_Period,1)>iHigh(_Symbol,_Period,2));
}

bool BearishOrderBlock()
{
   return (iClose(_Symbol,_Period,2)>iOpen(_Symbol,_Period,2) && iClose(_Symbol,_Period,1)<iLow(_Symbol,_Period,2));
}

bool BullishLiquiditySweep()
{
   double prevLow=LowestLowFrom(StructureLookback,2);
   return (prevLow>0 && iLow(_Symbol,_Period,1)<prevLow && iClose(_Symbol,_Period,1)>prevLow && BullishDisplacement(1));
}

bool BearishLiquiditySweep()
{
   double prevHigh=HighestHighFrom(StructureLookback,2);
   return (prevHigh>0 && iHigh(_Symbol,_Period,1)>prevHigh && iClose(_Symbol,_Period,1)<prevHigh && BearishDisplacement(1));
}

bool EqualHighs()
{
   double tolerance=MathMax(ATRValue[0]*0.10,_Point*10);
   return (MathAbs(iHigh(_Symbol,_Period,1)-iHigh(_Symbol,_Period,2))<=tolerance);
}

bool EqualLows()
{
   double tolerance=MathMax(ATRValue[0]*0.10,_Point*10);
   return (MathAbs(iLow(_Symbol,_Period,1)-iLow(_Symbol,_Period,2))<=tolerance);
}

bool BullishBreakerBlock()
{
   return (BearishOrderBlock() && iClose(_Symbol,_Period,1)>iHigh(_Symbol,_Period,2));
}

bool BearishBreakerBlock()
{
   return (BullishOrderBlock() && iClose(_Symbol,_Period,1)<iLow(_Symbol,_Period,2));
}

bool BullishMitigationBlock()
{
   return (BullishOrderBlock() && iLow(_Symbol,_Period,1)<=iHigh(_Symbol,_Period,2) && iClose(_Symbol,_Period,1)>iOpen(_Symbol,_Period,1));
}

bool BearishMitigationBlock()
{
   return (BearishOrderBlock() && iHigh(_Symbol,_Period,1)>=iLow(_Symbol,_Period,2) && iClose(_Symbol,_Period,1)<iOpen(_Symbol,_Period,1));
}

double PremiumDiscountValue()
{
   double high=HighestHighFrom(StructureLookback,1);
   double low=LowestLowFrom(StructureLookback,1);
   double range=high-low;
   if(range<=0)
      return 50.0;

   return (iClose(_Symbol,_Period,1)-low)*100.0/range;
}

bool DiscountZone()
{
   return (PremiumDiscountValue()<=50.0);
}

bool PremiumZone()
{
   return (PremiumDiscountValue()>=50.0);
}

bool KillZoneOK()
{
   MqlDateTime tm;
   TimeToStruct(TimeCurrent(),tm);

   bool london=(tm.hour>=7 && tm.hour<11);
   bool newYork=(tm.hour>=13 && tm.hour<17);
   return (london || newYork);
}

double SMCScore(bool buy)
{
   double score=0.0;

   if(buy)
   {
      if(BullishBOS()) score+=18;
      if(BullishCHOCH()) score+=14;
      if(BullishLiquiditySweep()) score+=18;
      if(BullishDisplacement()) score+=8;
      if(EqualLows()) score+=5;
      if(BullishOrderBlock()) score+=15;
      if(BullishBreakerBlock()) score+=10;
      if(BullishMitigationBlock()) score+=10;
      if(BullishFairValueGap()) score+=10;
      if(DiscountZone()) score+=5;
   }
   else
   {
      if(BearishBOS()) score+=18;
      if(BearishCHOCH()) score+=14;
      if(BearishLiquiditySweep()) score+=18;
      if(BearishDisplacement()) score+=8;
      if(EqualHighs()) score+=5;
      if(BearishOrderBlock()) score+=15;
      if(BearishBreakerBlock()) score+=10;
      if(BearishMitigationBlock()) score+=10;
      if(BearishFairValueGap()) score+=10;
      if(PremiumZone()) score+=5;
   }

   if(KillZoneOK()) score+=10;
   return MathMin(score,100.0);
}

string SMCText()
{
   double buy=SMCScore(true);
   double sell=SMCScore(false);

   if(buy>=sell && buy>=50)
      return "Xarid SMC "+DoubleToString(buy,0);

   if(sell>buy && sell>=50)
      return "Sotish SMC "+DoubleToString(sell,0);

   return "Kutish";
}

double PatternScore(bool buy)
{
   if(!UseSelfLearning)
      return 50.0;

   int total=0;
   int wins=0;

   for(int i=0;i<MEMORY_SIZE;i++)
   {
      if(Memory[i].Time==0)
         continue;

      if(Memory[i].Buy!=buy)
         continue;

      total++;
      if(Memory[i].Profit>0)
         wins++;
   }

   if(total<5)
      return 50.0;

   return wins*100.0/total;
}

double AdaptiveFilterBonus(bool buy)
{
   double pattern=PatternScore(buy);

   if(pattern>=65.0)
      return 8.0;

   if(pattern<=35.0)
      return -12.0;

   return 0.0;
}

double OptimizedStopLossATR()
{
   if(!UseAutoOptimizer)
      return StopLossATR;

   double winRate=GetMemoryWinRate();
   double value=StopLossATR;

   if(winRate<45.0)
      value*=0.90;
   else if(winRate>65.0)
      value*=1.05;

   if(DrawdownPercent()>MaxDrawdown*0.50)
      value*=0.85;

   return MathMax(value,0.50);
}

double OptimizedTakeProfitATR()
{
   if(!UseAutoOptimizer)
      return TakeProfitATR;

   double winRate=GetMemoryWinRate();
   double value=TakeProfitATR;

   if(winRate<45.0)
      value*=0.90;
   else if(winRate>65.0)
      value*=1.10;

   return MathMax(value,0.80);
}

double MemoryProfitFactor()
{
   double grossProfit=0.0;
   double grossLoss=0.0;
   int used=0;

   for(int i=MEMORY_SIZE-1;i>=0 && used<OptimizerLookback;i--)
   {
      int index=(MemoryIndex+i)%MEMORY_SIZE;
      if(Memory[index].Time==0)
         continue;

      used++;
      if(Memory[index].Profit>0)
         grossProfit+=Memory[index].Profit;
      else
         grossLoss+=MathAbs(Memory[index].Profit);
   }

   if(grossLoss<=0)
      return (grossProfit>0 ? 3.0 : 1.0);

   return grossProfit/grossLoss;
}

double OptimizedRiskMultiplier()
{
   if(!UseSelfLearning)
      return 1.0;

   double winRate=GetMemoryWinRate();
   double profitFactor=MemoryProfitFactor();
   double dd=DrawdownPercent();

   if(winRate<40.0 || profitFactor<0.80)
      return 0.60;

   if(dd>MaxDrawdown*0.50)
      return 0.50;

   if(winRate>70.0 && profitFactor>1.40 && dd<MaxDrawdown*0.25)
      return 1.15;

   return 1.0;
}

double DirectionalAIScore(bool buy)
{
   double score=0.0;

   score += (buy ? GetBuyPower() : GetSellPower())*0.20;
   score += (buy ? GetBuyProbability() : GetSellProbability())*0.15;
   score += SMCScore(buy)*0.20;
   score += GetTrendStrength()*0.10;
   score += AdaptiveFilterBonus(buy);
   score += (ADXValue[0]>=MinADX ? 10.0 : 0.0);
   score += (ATRFilterOK() ? 10.0 : 0.0);
   score += (VolumeFilterOK() ? 5.0 : 0.0);
   score += (SessionOK() ? 5.0 : 0.0);
   score += (SpreadOK() ? 5.0 : 0.0);
   score += (NewsOK() ? 5.0 : 0.0);

   if(ArraySize(RSIValue)>0)
   {
      if(buy && RSIValue[0]>=BuyRSIMin) score+=5.0;
      if(!buy && RSIValue[0]<=SellRSIMax) score+=5.0;
   }

   return MathMin(score,100.0);
}

string EntryBlockReason(bool buy)
{
   double directional=DirectionalAIScore(buy);
   double smc=SMCScore(buy);

   if(buy)
   {
      double close1=iClose(_Symbol,_Period,1);
      double highBreak=HighestHighFrom(BreakoutBars,2);
      if(!(FastEMAValue[0]>SlowEMAValue[0] && SlowEMAValue[0]>TrendEMAValue[0])) return "Xarid trend mos emas";
      if(UseADXFilter && ADXValue[0]<MinADX) return "ADX kuchsiz";
      if(!(close1>highBreak || BullishBOS() || BullishCHOCH())) return "Breakout/BOS yo'q";
      if(!(smc>=MinSMCScore || BullishLiquiditySweep() || BullishBreakerBlock() || BullishMitigationBlock())) return "SMC baho past";
      if(RSIValue[0]<BuyRSIMin) return "RSI xarid uchun past";
      if(PlusDI[0]<MinusDI[0]) return "+DI tasdiqlamadi";
      if(!HTFTrendBuy()) return "Yuqori TF xaridga qarshi";
      if(!AIAllowBuy()) return "AI bozor ishonchi past";
      if(directional<MinAIScore) return "Xarid AI baho past";
   }
   else
   {
      double close1=iClose(_Symbol,_Period,1);
      double lowBreak=LowestLowFrom(BreakoutBars,2);
      if(!(FastEMAValue[0]<SlowEMAValue[0] && SlowEMAValue[0]<TrendEMAValue[0])) return "Sotish trend mos emas";
      if(UseADXFilter && ADXValue[0]<MinADX) return "ADX kuchsiz";
      if(!(close1<lowBreak || BearishBOS() || BearishCHOCH())) return "Breakout/BOS yo'q";
      if(!(smc>=MinSMCScore || BearishLiquiditySweep() || BearishBreakerBlock() || BearishMitigationBlock())) return "SMC baho past";
      if(RSIValue[0]>SellRSIMax) return "RSI sotish uchun baland";
      if(MinusDI[0]<PlusDI[0]) return "-DI tasdiqlamadi";
      if(!HTFTrendSell()) return "Yuqori TF sotishga qarshi";
      if(!AIAllowSell()) return "AI bozor ishonchi sotishga mos emas";
      if(directional<MinAIScore) return "Sotish AI baho past";
   }

   return "Kirishga ruxsat";
}

bool BuySignal()
{
   double close1=iClose(_Symbol,_Period,1);
   double highBreak=HighestHighFrom(BreakoutBars,2);
   bool trend=(FastEMAValue[0]>SlowEMAValue[0] && SlowEMAValue[0]>TrendEMAValue[0]);
   bool momentum=(!UseADXFilter || ADXValue[0]>=MinADX);
   bool breakout=(close1>highBreak || BullishBOS() || BullishCHOCH());
   bool smartMoney=(SMCScore(true)>=MinSMCScore || BullishLiquiditySweep() || BullishBreakerBlock() || BullishMitigationBlock());
   bool rsiOK=(ArraySize(RSIValue)==0 || RSIValue[0]>=BuyRSIMin);
   bool diOK=(ArraySize(PlusDI)==0 || PlusDI[0]>=MinusDI[0]);
   return trend && momentum && breakout && smartMoney && rsiOK && diOK && HTFTrendBuy() && AIAllowBuy() && DirectionalAIScore(true)>=MinAIScore;
}

bool SellSignal()
{
   double close1=iClose(_Symbol,_Period,1);
   double lowBreak=LowestLowFrom(BreakoutBars,2);
   bool trend=(FastEMAValue[0]<SlowEMAValue[0] && SlowEMAValue[0]<TrendEMAValue[0]);
   bool momentum=(!UseADXFilter || ADXValue[0]>=MinADX);
   bool breakout=(close1<lowBreak || BearishBOS() || BearishCHOCH());
   bool smartMoney=(SMCScore(false)>=MinSMCScore || BearishLiquiditySweep() || BearishBreakerBlock() || BearishMitigationBlock());
   bool rsiOK=(ArraySize(RSIValue)==0 || RSIValue[0]<=SellRSIMax);
   bool diOK=(ArraySize(MinusDI)==0 || MinusDI[0]>=PlusDI[0]);
   return trend && momentum && breakout && smartMoney && rsiOK && diOK && HTFTrendSell() && AIAllowSell() && DirectionalAIScore(false)>=MinAIScore;
}

bool TryPartialClose(double profitDistance,double atr,double volume)
{
   if(!UsePartialClose || profitDistance<PartialATR*atr)
      return false;

   double minVolume=SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   if(volume<=minVolume)
      return false;

   string gv="MADINA_PARTIAL_"+IntegerToString((int)PositionGetInteger(POSITION_TICKET));
   if(GlobalVariableCheck(gv))
      return false;

   double closeVolume=NormalizeDouble(volume*PartialPercent/100.0,2);
   if(closeVolume>=minVolume && closeVolume<volume)
   {
      trade.PositionClosePartial(_Symbol,closeVolume);
      GlobalVariableSet(gv,TimeCurrent());
      return true;
   }

   return false;
}

double BuyManagedStop(double open,double sl,double bid,double atr)
{
   double newSL=sl;
   double profitDistance=bid-open;

   if(UseBreakEven && profitDistance>=BreakEvenATR*atr)
      newSL=MathMax(newSL,open+BreakEvenLockATR*atr);

   if(UseTrailing && profitDistance>=TrailStartATR*atr)
   {
      double trailSL=bid-TrailATR*atr;
      if(sl==0 || trailSL>newSL+TrailStepATR*atr)
         newSL=trailSL;
   }

   return newSL;
}

double SellManagedStop(double open,double sl,double ask,double atr)
{
   double newSL=sl;
   double profitDistance=open-ask;

   if(UseBreakEven && profitDistance>=BreakEvenATR*atr)
      newSL=(newSL==0 ? open-BreakEvenLockATR*atr : MathMin(newSL,open-BreakEvenLockATR*atr));

   if(UseTrailing && profitDistance>=TrailStartATR*atr)
   {
      double trailSL=ask+TrailATR*atr;
      if(sl==0 || trailSL<newSL-TrailStepATR*atr)
         newSL=trailSL;
   }

   return newSL;
}

void ManageBuyPosition(double open,double sl,double tp,double volume,double atr,double bid)
{
   double profitDistance=bid-open;
   double newSL=BuyManagedStop(open,sl,bid,atr);

   if(newSL>0 && (sl==0 || newSL>sl+_Point))
      trade.PositionModify(_Symbol,NormalizePrice(newSL),tp);

   TryPartialClose(profitDistance,atr,volume);
}

void ManageSellPosition(double open,double sl,double tp,double volume,double atr,double ask)
{
   double profitDistance=open-ask;
   double newSL=SellManagedStop(open,sl,ask,atr);

   if(newSL>0 && (sl==0 || newSL<sl-_Point))
      trade.PositionModify(_Symbol,NormalizePrice(newSL),tp);

   TryPartialClose(profitDistance,atr,volume);
}

void ManageOpenPosition()
{
   if(!PositionSelect(_Symbol))
      return;

   if((ulong)PositionGetInteger(POSITION_MAGIC)!=Magic)
      return;

   if(ArraySize(ATRValue)==0 || ATRValue[0]<=0)
      return;

   long type=PositionGetInteger(POSITION_TYPE);
   double open=PositionGetDouble(POSITION_PRICE_OPEN);
   double sl=PositionGetDouble(POSITION_SL);
   double tp=PositionGetDouble(POSITION_TP);
   double volume=PositionGetDouble(POSITION_VOLUME);
   double atr=ATRValue[0];

   if(type==POSITION_TYPE_BUY)
      ManageBuyPosition(open,sl,tp,volume,atr,BidPrice());
   else if(type==POSITION_TYPE_SELL)
      ManageSellPosition(open,sl,tp,volume,atr,AskPrice());
}

//==============================================================
//                      ASOSIY SIKL
//==============================================================

bool EntryPreconditionsOK()
{
   if(!AppRisk.CanTrade())
   {
      LastBlockReason="Risk limiti savdoni toxtatdi";
      return false;
   }

   if(!SpreadOK())
   {
      LastBlockReason="Spred juda katta";
      return false;
   }

   if(!SessionOK())
   {
      LastBlockReason="Sessiya yopiq";
      return false;
   }

   if(!AppNews.CanTrade())
   {
      LastBlockReason="Yangilik filtri";
      return false;
   }

   if(!ATRFilterOK())
   {
      LastBlockReason="ATR diapazondan tashqari";
      return false;
   }

   if(!VolumeFilterOK())
   {
      LastBlockReason="Hajm yetarli emas";
      return false;
   }

   if(!FlatFilterOK())
   {
      LastBlockReason="Flat bozor";
      return false;
   }

   if(!EnoughBarsAfterTrade())
   {
      LastBlockReason="Savdolar oraligi kutilmoqda";
      return false;
   }

   return true;
}

bool TradeLotOK(double stopDistance,double &lot)
{
   lot=AppRisk.Lot(stopDistance);
   if(lot>0)
      return true;

   LastBlockReason="Lot hisoblash 0 chiqdi";
   return false;
}

bool EntryAIScoreOK()
{
   double AIScore=MathMax(DirectionalAIScore(true),DirectionalAIScore(false));
   if(AIScore>=MinAIScore)
      return true;

   LastBlockReason="AI umumiy baho past: "+DoubleToString(AIScore,1);
   AppLogger.Info("AI filtri kirishni rad etdi. Baho = "+DoubleToString(AIScore,1));
   return false;
}

bool ExecuteBuyEntry(double lot,double ask,double sl,double tp,datetime currentBar)
{
   if(trade.Buy(lot,_Symbol,ask,sl,tp,"Madina xarid ATR"))
   {
      LastTradeBar=currentBar;
      LastBlockReason="Xarid ochildi";
      Print("XARID MUVAFFAQIYAT lot=",DoubleToString(lot,2)," SL=",DoubleToString(sl,_Digits)," TP=",DoubleToString(tp,_Digits));
      return true;
   }

   LastBlockReason="Xarid ijro xatosi: "+IntegerToString((int)trade.ResultRetcode());
   Print("XARID XATO = ",trade.ResultRetcode());
   return false;
}

bool ExecuteSellEntry(double lot,double bid,double sl,double tp,datetime currentBar)
{
   if(trade.Sell(lot,_Symbol,bid,sl,tp,"Madina sotish ATR"))
   {
      LastTradeBar=currentBar;
      LastBlockReason="Sotish ochildi";
      Print("SOTISH MUVAFFAQIYAT lot=",DoubleToString(lot,2)," SL=",DoubleToString(sl,_Digits)," TP=",DoubleToString(tp,_Digits));
      return true;
   }

   LastBlockReason="Sotish ijro xatosi: "+IntegerToString((int)trade.ResultRetcode());
   Print("SOTISH XATO = ",trade.ResultRetcode());
   return false;
}

void EvaluateEntry(datetime currentBar)
{
   double Ask=AskPrice();
   double Bid=BidPrice();
   double ATR=ATRValue[0];

   double slAtr=OptimizedStopLossATR();
   double tpAtr=OptimizedTakeProfitATR();

   double SLBuy=NormalizePrice(Ask-ATR*slAtr);
   double TPBuy=NormalizePrice(Ask+ATR*tpAtr);
   double SLSell=NormalizePrice(Bid+ATR*slAtr);
   double TPSell=NormalizePrice(Bid-ATR*tpAtr);

   double Lot=0.0;
   if(!TradeLotOK(ATR*slAtr,Lot))
      return;

   if(!EntryAIScoreOK())
      return;

   LastBlockReason=EntryBlockReason(true)+" | "+EntryBlockReason(false);

   if(AppEntry.Buy())
      ExecuteBuyEntry(Lot,Ask,SLBuy,TPBuy,currentBar);
   else if(AppEntry.Sell())
      ExecuteSellEntry(Lot,Bid,SLSell,TPSell,currentBar);
}

void OnTick()
{
   UpdateAIMode();

   if(!RefreshIndicators())
      return;

   AppExit.Manage();

   if(CurrentMode==MODE_STOP || (UseSafeMode && CurrentMode==MODE_STOP))
   {
      LastBlockReason="AI STOP rejimi";
      AppDashboard.Render();
      return;
   }

   if(PositionOpened())
   {
      LastBlockReason="Ochiq robot pozitsiyasi bor";
      AppDashboard.Render();
      return;
   }

   if(!EntryPreconditionsOK())
   {
      AppDashboard.Render();
      return;
   }

   datetime currentBar=iTime(_Symbol,_Period,0);
   if(currentBar==LastTradeBar)
      return;

   EvaluateEntry(currentBar);

   AppDashboard.Render();
}
void OnTradeTransaction(const MqlTradeTransaction &trans,
                        const MqlTradeRequest &request,
                        const MqlTradeResult &result)
{
   if(trans.type!=TRADE_TRANSACTION_DEAL_ADD)
      return;

   if(!HistoryDealSelect(trans.deal))
      return;

   if(HistoryDealGetString(trans.deal,DEAL_SYMBOL)!=_Symbol)
      return;

   if((ulong)HistoryDealGetInteger(trans.deal,DEAL_MAGIC)!=Magic)
      return;

   ENUM_DEAL_ENTRY entry=(ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal,DEAL_ENTRY);
   if(entry!=DEAL_ENTRY_OUT && entry!=DEAL_ENTRY_INOUT && entry!=DEAL_ENTRY_OUT_BY)
      return;

   double profit=HistoryDealGetDouble(trans.deal,DEAL_PROFIT)+HistoryDealGetDouble(trans.deal,DEAL_SWAP)+HistoryDealGetDouble(trans.deal,DEAL_COMMISSION);
   ENUM_DEAL_TYPE dealType=(ENUM_DEAL_TYPE)HistoryDealGetInteger(trans.deal,DEAL_TYPE);
   bool IsBuy=(dealType==DEAL_TYPE_SELL);

   SaveTradeMemory(IsBuy,profit);

   if(profit>0)
   {
      WinSeries++;
      LossSeries=0;

      Print("FOYDA KETMA-KET = ",WinSeries);
   }

   if(profit<0)
   {
      LossSeries++;
      WinSeries=0;

      Print("ZARAR KETMA-KET = ",LossSeries);
   }

   UpdateAIMode();

   Print("AI REJIM = ",ModeName());

}
//==============================================================
//                 XARID AI BAHO
//==============================================================

double GetBuyAIScore()
{
   double score = 0;

   score += GetBuyPower() * 0.45;

   score += GetConfidence() * 0.35;

   if(ADXValue[0] >= MinADX)
      score += 10;

   if(FastEMAValue[0] > SlowEMAValue[0])
      score += 10;

   if(score > 100)
      score = 100;

   return score;
}

//==============================================================
//                 SOTISH AI BAHO
//==============================================================

double GetSellAIScore()
{
   double score = 0;

   score += GetSellPower() * 0.45;

   score += (100.0 - GetConfidence()) * 0.35;

   if(ADXValue[0] >= MinADX)
      score += 10;

   if(FastEMAValue[0] < SlowEMAValue[0])
      score += 10;

   if(score > 100)
      score = 100;

   return score;
}
//==============================================================
//             AI TREND KUCHI
//==============================================================

double GetTrendStrength()
{
   double strength = 0;

   double distance = MathAbs(FastEMAValue[0] - SlowEMAValue[0]);

   strength += MathMin(distance * 10000.0,40.0);

   if(ADXValue[0] > 20)
      strength += 20;

   if(ADXValue[0] > 30)
      strength += 20;

   if(ADXValue[0] > 40)
      strength += 20;

   if(strength > 100)
      strength = 100;

   return strength;
}
//==============================================================
//                 SAVDONI AI XOTIRAGA YOZISH
//==============================================================

void SaveTradeMemory(bool IsBuy,double ProfitValue)
{
   Memory[MemoryIndex].Time       = TimeCurrent();
   Memory[MemoryIndex].Buy        = IsBuy;
   Memory[MemoryIndex].Profit     = ProfitValue;

   Memory[MemoryIndex].ATR        = ATRValue[0];
   Memory[MemoryIndex].ADX        = ADXValue[0];

   Memory[MemoryIndex].Confidence = GetConfidence();

   Memory[MemoryIndex].BuyPower   = GetBuyPower();
   Memory[MemoryIndex].SellPower  = GetSellPower();
   MemoryIndex++;

   if(MemoryIndex>=MEMORY_SIZE)
      MemoryIndex=0;
}
//==============================================================
//          AI XOTIRA YUTUQ FOIZI
//==============================================================

double GetMemoryWinRate()
{
   int total = 0;
   int wins = 0;

   for(int i=0;i<MEMORY_SIZE;i++)
   {
      if(Memory[i].Time==0)
         continue;

      total++;

      if(Memory[i].Profit>0)
         wins++;
   }

   if(total==0)
      return 50.0;

   return wins*100.0/total;
}
//==============================================================
//          AI OZI ORGANISHI
//==============================================================

double GetLearningBonus()
{
   int good = 0;
   int bad  = 0;

   for(int i=0;i<MEMORY_SIZE;i++)
   {
      if(Memory[i].Time==0)
         continue;

      if(Memory[i].Profit>0 &&
         Memory[i].Confidence>=70)
         good++;

      if(Memory[i].Profit<0 &&
         Memory[i].Confidence>=70)
         bad++;
   }

   if(good > bad)
      return 5.0;

   if(bad > good)
      return -5.0;

   return 0.0;
}
//==============================================================
//            AI BOZOR INTELLEKTI
//==============================================================

double GetMarketIntelligence()
{
   double score = 0;

   // Oltin uchun odatda zaif DXY ijobiy omil
   if(TrendDirection(DXY)==-1)
      score += 15;

   // Fond bozorining osishi
   if(TrendDirection(SP500)==1)
      score += 10;

   if(TrendDirection(NASDAQ)==1)
      score += 10;

   // Kumushning osishi
   if(TrendDirection(SILVER)==1)
      score += 10;

   // Neftning osishi
   if(TrendDirection(OIL)==1)
      score += 5;

   // BTCning osishi
   if(TrendDirection(BTC)==1)
      score += 5;

   if(score>50)
      score=50;

   return score;
}
//==============================================================
//                  MADINA AI HUD
//==============================================================

void DrawHUD()
{
   if(!ShowHUD)
      return;

   string txt;

   txt =
   "══════════════════════════════\n";

   txt += " MADINA AI TRADER PRO X\n";

   txt += "══════════════════════════════\n\n";

   txt += "AI REJIM : " + ModeName() + "\n";

   txt += "AI BAHO : " +
       DoubleToString(GetAIScore(),1) + "%\n";

txt += "XARID KUCHI : " +
       DoubleToString(GetBuyPower(),1) + "%\n";

txt += "SOTISH KUCHI : " +
       DoubleToString(GetSellPower(),1) + "%\n";

txt += "XARID EHTIMOLI : " +
       DoubleToString(GetBuyProbability(),1) + "%\n";

txt += "SOTISH EHTIMOLI : " +
       DoubleToString(GetSellProbability(),1) + "%\n\n";

   txt += "BALANS : " +
          DoubleToString(Balance(),2) + "\n";

   txt += "EQUITY : " +
          DoubleToString(Equity(),2) + "\n";

   txt += "FOYDA : " +
          DoubleToString(Profit(),2) + "\n\n";

   txt += "ADX : " +
          DoubleToString(ADXValue[0],1) + "\n";

   txt += "ATR : " +
          DoubleToString(ATRValue[0],2) + "\n";

   txt += "SPRED : " +
          DoubleToString((AskPrice()-BidPrice())/_Point,1) + "\n";

   txt += "KUNLIK FOYDA : " + DoubleToString(TodayClosedProfit(),2) + "\n";
   txt += "DRAWDOWN : " + DoubleToString(DrawdownPercent(),2) + "%\n";
   txt += "TREND : " + TrendText() + "\n";
   txt += "SESSIYA : " + SessionText() + "\n";
   txt += "YANGILIK : " + NewsText() + "\n";
   txt += "SMC : " + SMCText() + "\n";
   txt += "SABAB : " + LastBlockReason + "\n";
   txt += "XARID XOTIRA : " + DoubleToString(PatternScore(true),1) + "%\n";
   txt += "SOTISH XOTIRA : " + DoubleToString(PatternScore(false),1) + "%\n";
   txt += "PROFIT FACTOR : " + DoubleToString(MemoryProfitFactor(),2) + "\n";
   txt += "LOT MOSLASHUV : " + DoubleToString(DrawdownLotMultiplier()*OptimizedRiskMultiplier(),2) + "x\n";

   txt += "\n";

   txt += "FOYDA SERIYASI : " + IntegerToString(WinSeries) + "\n";

   txt += "ZARAR SERIYASI : " + IntegerToString(LossSeries) + "\n";

   txt += "\n";

   txt += "HOLAT : TAYYOR";

   Comment(txt);
}
//==============================================================
//               YOZUV YARATISH
//==============================================================

void CreateLabel(string name,
                 string text,
                 int x,
                 int y,
                 color clr,
                 int size=10)
{
   if(ObjectFind(0,name)<0)
      ObjectCreate(0,name,OBJ_LABEL,0,0,0);

   ObjectSetInteger(0,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,y);

   ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,size);

   ObjectSetString(0,name,OBJPROP_FONT,"Segoe UI");

   ObjectSetString(0,name,OBJPROP_TEXT,text);
}
//==============================================================
//                AI PANELNI CHIZISH
//==============================================================

void DrawPanel()
{
   CreateLabel("T1","🤖 MADINA AI TRADER PRO",15,15,clrDeepSkyBlue,14);
   CreateLabel("T2","AI REJIM : "+ModeName(),15,45,clrWhite);
   CreateLabel("T3","AI BAHO : "+DoubleToString(GetAIScore(),1)+" %",15,65,clrLime);
   CreateLabel("T4","XARID BAHO : "+DoubleToString(DirectionalAIScore(true),1)+" %",15,85,clrLime);
   CreateLabel("T5","SOTISH BAHO : "+DoubleToString(DirectionalAIScore(false),1)+" %",15,105,clrTomato);
   CreateLabel("T6","BALANS : "+DoubleToString(Balance(),2),15,130,clrWhite);
   CreateLabel("T7","EQUITY : "+DoubleToString(Equity(),2),15,150,clrWhite);
   CreateLabel("T8","SUZUVCHI FOYDA : "+DoubleToString(Profit(),2),15,170,clrYellow);
   CreateLabel("T9","KUNLIK FOYDA : "+DoubleToString(TodayClosedProfit(),2),15,190,clrAqua);
   CreateLabel("T10","DRAWDOWN : "+DoubleToString(DrawdownPercent(),2)+" %",15,210,clrOrange);
   CreateLabel("T11","SPRED : "+DoubleToString((AskPrice()-BidPrice())/_Point,1),15,230,clrWhite);
   CreateLabel("T12","ATR : "+DoubleToString(ATRValue[0],_Digits),15,250,clrWhite);
   CreateLabel("T13","ADX : "+DoubleToString(ADXValue[0],1),15,270,clrWhite);
   CreateLabel("T14","RSI : "+DoubleToString(RSIValue[0],1),15,290,clrWhite);
   CreateLabel("T15","TREND : "+TrendText(),15,310,clrDeepSkyBlue);
   CreateLabel("T16","SESSIYA : "+SessionText(),15,330,(SessionOK()?clrLime:clrTomato));
   CreateLabel("T17","YANGILIK : "+NewsText(),15,350,(NewsOK()?clrLime:clrTomato));
   CreateLabel("T18","SMC : "+SMCText(),15,370,clrGold);
   CreateLabel("T19","XOTIRA WINRATE : "+DoubleToString(GetMemoryWinRate(),1)+" %",15,390,clrAqua);
   CreateLabel("T20","OPT SL ATR : "+DoubleToString(OptimizedStopLossATR(),2),15,410,clrWhite);
   CreateLabel("T21","OPT TP ATR : "+DoubleToString(OptimizedTakeProfitATR(),2),15,430,clrWhite);
   CreateLabel("T22","PROFIT FACTOR : "+DoubleToString(MemoryProfitFactor(),2),15,450,clrAqua);
   CreateLabel("T23","LOT MOSLASHUV : "+DoubleToString(DrawdownLotMultiplier()*OptimizedRiskMultiplier(),2)+" x",15,470,clrGold);
   CreateLabel("T24","SAVDO SABABI : "+LastBlockReason,15,490,clrWhite);
   CreateLabel("T25","SMC XARID/SOTISH : "+DoubleToString(SMCScore(true),0)+" / "+DoubleToString(SMCScore(false),0),15,510,clrGold);
}
