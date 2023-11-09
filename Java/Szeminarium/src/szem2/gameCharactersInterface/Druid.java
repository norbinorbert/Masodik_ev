package szem2.gameCharactersInterface;

public class Druid implements IGameCharacter{
    private String name;
    private int age;
    private String skill;

    public Druid(String name, int age, String skill) {
        this.name = name;
        this.age = age;
        this.skill = skill;
    }

    @Override
    public String toString() {
        return "Druid{" + "name='" + name + '\'' +", age=" + age + ", skill='" + skill + '\'' + '}';
    }

    @Override
    public void executeSkill() {
        System.out.println(name + " casts: " + skill);
    }
}
