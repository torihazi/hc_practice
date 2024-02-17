class Pokemon
    attr_reader :mp

    def initialize
        @name = 'リザードン'
        @type1 = 'ほのお'
        @type2 = 'ひこう'
        @hp = 100
        @mp = 10
    end

    def attack
        "#{@name}のこうげき!"
    end
end
