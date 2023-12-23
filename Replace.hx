package ;

import sys.io.File;

class Replace {

    static var dateRegex = ~/((\d+)\/(\d+)\/(\d+))/;
    static var assumeAmerican = true;

    static public function main() {
        var file = File.getContent("lang.json");
        var lines = file.split("\n");
        var outputLines:Array<String> = [];

        for (line in lines) {
            var repString = "";
            if (dateRegex.match(line)) {
                // Sys.println('${dateRegex.matched(2)}/${dateRegex.matched(3)}/${dateRegex.matched(4)}');
                Sys.println(line);
                if (assumeAmerican) {
                    // Assumes the input is in MM/DD/YY(YY)? format
                    var dayString = (dateRegex.matched(3).length < 2) ? '0${dateRegex.matched(3)}' : dateRegex.matched(3);
                    var monthString = (dateRegex.matched(2).length < 2) ? '0${dateRegex.matched(2)}' : dateRegex.matched(2);
                } else {
                    // Assume input is in the REAL format, DD/MM/YY(YY)?
                    var dayString = (dateRegex.matched(2).length < 2) ? '0${dateRegex.matched(2)}' : dateRegex.matched(2);
                    var monthString = (dateRegex.matched(3).length < 2) ? '0${dateRegex.matched(3)}' : dateRegex.matched(3);
                }
                repString = dateRegex.replace(line, '${dayString}/${monthString}/${dateRegex.matched(4)}');
                Sys.println(repString);
                line = repString;
            }
            outputLines.push(line);
        }

        var outString = outputLines.join("\n");
        var fileOut = File.write("out.json", false);
        fileOut.writeString(outString);
        fileOut.flush();
        fileOut.close();
    }
}

