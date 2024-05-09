import 'dart:math' as math;

class Parser{
   static int parseAuthorReputation(int rawRep) {
    String rep = rawRep.toString();
    bool neg = rep.startsWith("-");
    rep = neg ? rep.substring(1) : rep;
    double out = math.log(int.parse(rep)) / math.log(10);
    if (out.isInfinite) out = 0;
    out = math.max(out - 9, 0);
    out = (neg ? -1 : 1) * out;
    out = out * 9 + 25;
    return out.toInt();
  }

  static String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}