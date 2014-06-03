class MemberMailer < ActionMailer::Base
  default from: "DAH Server <a.durity@umail.ucc.ie>"

  # TODO CONST
  def accept_reject_story(member, scan, story, accept_reject)
    @member = member
    @url  = 'http://dh.ucc.ie/boole/'
    @scan = scan
    @item = Item.find @scan.item_id
    @story = story
    mail(to: @member.email, subject: "#{@item.fa_seq} ……… Transcription: #{@scan.minor_seq} of #{@item.scans.length} - #{accept_reject}")
  end
end
