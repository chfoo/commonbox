package commonbox;

import utest.Runner;
import utest.ui.Report;


class TestAll {
    public static function main() {
        var runner = new Runner();
        runner.addCases(commonbox.tests);
        Report.create(runner);
        runner.run();
    }
}
