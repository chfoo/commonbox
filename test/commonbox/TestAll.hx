package commonbox;

import utest.Runner;
import utest.ui.Report;


class TestAll {
    public static function main() {
        var runner = new Runner();
        runner.addCases(commonbox.tests);
        var report = Report.create(runner);

        #if coverage
        report.setHandler(coverageHandler);
        #end

        runner.run();
    }

    static function coverageHandler(handler) {
        #if coverage
        trace("Running coverage report");
        var logger = mcover.coverage.MCoverage.getLogger();
        logger.report();
        #end
    }
}
