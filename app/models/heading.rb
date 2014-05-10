class Heading < ActiveRecord::Base

    # who, where, ~when, ~what, ~how
    # I confess I've taken the idea of activities from FromThePage
    TYPES=['person', 'place', 'event', 'concept', 'activity']

    self::NO_TYPE = ""

    has_many :locators
end

Heading::TYPES.each do |t|
    # klass = Object.const_set name, Struct.new(*attributes)
    klass = Object.const_set t.capitalize, Class.new(Heading)
    klass.define_singleton_method(:hello) { "#{self}: Hello there!" }
    # klass.define_singleton_method(:model_name) { Heading.model_name }
    
    # tis private lad
    # klass.define_method(:to_partial_path) { 'headings/heading' }
    
    klass.send( :define_method, :to_partial_path) { 'headings/heading' }

    # klass.metaclass.send(:define_method, :model_name) do
    #     Heading.model_name
    # end
end

# An index (plural: usually indexes, see below) is a list of words or phrases
# ('headings') and associated pointers ('locators') to where useful material
# relating to that heading can be found in a document. In a traditional
# back-of-the-book index the headings will include names of people, places and
# events, and concepts selected by a person as being
# relevant and of interest to a possible reader of the book.

# https://en.wikipedia.org/wiki/Five_Ws
#
# Who is it about? 
# What happened?
# When did it take place?
# Where did it take place? 
# Why did it happen?
# How did it happen?
#
# Quis, quid, quando, ubi, cur, quem ad modum, quibus adminiculis.
# (Who, what, when, where, why, in what way, by what means)

# Heidegger - question concerning technology
#
# For centuries philosophy has taught that there are four causes: (1) the causa
# materialis, the material, the matter out of which, for example, a silver chalice is
# made; (2) the causa formalis, the form, the shape into which the material
# enters; (3) the causa finalis, the end, for example, the sacrificial rite in relation
# to which the chalice required is determined as to its form and matter; (4) the
# causa efficiens, which brings about the effect that is the finished, actual chalice,
# in this instance, the silversmith. What technology is, when represented as a
# means, discloses itself when we trace instrumentality back to fourfold causality.

# causa materialis - from what
# causa formalis   - in what way
# causa finalis    - to what end
# cause efficiens  - by what means

