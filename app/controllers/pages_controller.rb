class PagesController < ApplicationController
    def welcome
    end

    def browse
    end

    def locked_by_member
        @all_scans = Scan.all
        @member_scans = @all_scans.keep_if { |s| current_member.id == s.versions.last.whodunnit.to_i }
        @locked_scans = @member_scans.keep_if { |s| s.state == Scan::LOCKED }
    end

    def intro
        # render Introduction section from Collection YAML Config as Markdown
    end
end
