from dojo.models import Test
from dojo.tools.xanitizer.parser import XanitizerParser

from ..dojo_test_case import DojoTestCase, get_unit_tests_path


class TestXanitizerParser(DojoTestCase):

    def test_parse_file_with_no_findings(self):
        with open("unittests/scans/xanitizer/no-findings.xml") as testfile:
            parser = XanitizerParser()
            findings = parser.get_findings(testfile, Test())
            self.assertEqual(0, len(findings))

    def test_parse_file_with_one_findings(self):
        with open("unittests/scans/xanitizer/one-findings.xml") as testfile:
            parser = XanitizerParser()
            findings = parser.get_findings(testfile, Test())
            self.assertEqual(1, len(findings))

    def test_parse_file_with_multiple_findings(self):
        with open("unittests/scans/xanitizer/multiple-findings.xml") as testfile:
            parser = XanitizerParser()
            findings = parser.get_findings(testfile, Test())
            self.assertEqual(9, len(findings))
            finding = findings[5]
            self.assertEqual(1, len(finding.unsaved_vulnerability_ids))
            self.assertEqual("CVE-2015-5211", finding.unsaved_vulnerability_ids[0])

    def test_parse_file_with_multiple_findings_no_details(self):
        with open(get_unit_tests_path() + "/scans/xanitizer/multiple-findings-no-details.xml") as testfile:
            parser = XanitizerParser()
            findings = parser.get_findings(testfile, Test())
            self.assertEqual(9, len(findings))
