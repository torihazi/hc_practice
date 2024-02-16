class Pokemon
    attr_reader :name
    private attr_writer :name

    def initialize(name, type1, type2, hp) 
        @name = name
        @type1 = type1
        @type2 = type2
        @hp = hp
    end

    def changeName(name)
        raise '不適切名前です' if name.eql?('うんこ')

        @name = name
    end

end

class Pikachu < Pokemon
    def initialize(name, type1, type2, hp)
        super(name, type1, type2, hp)
    end

    def attack()
        "#{@name}の10万ボルト!"
    end

    def changeName(name)
        super(name)
    end
end
