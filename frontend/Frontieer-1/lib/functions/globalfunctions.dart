import '../const/messges.dart';

validate(String  val , int max ,int  min )
{
if (val.length<min)
{
  return messagemin;
}
if (val.length>max)
{
  return messagemax;
}
if (val.isEmpty)
{
  return messageEmpty;
}
}