package szem2.gameCharactersAbstract;

public class Druid extends GameCharacter {
    private String spell;

    public Druid(String name, int age, String spell) {
        super(name, age);
        this.spell = spell;
    }

    public String getSpell() {
        return spell;
    }

    public void setSpell(String spell) {
        this.spell = spell;
    }

    @Override
    public String toString() {
        return (super.toString() + "   spell= " + spell);
    }

    @Override
    public void executeSkill() {
        System.out.println("Druid casted: " + spell);
    }
}
