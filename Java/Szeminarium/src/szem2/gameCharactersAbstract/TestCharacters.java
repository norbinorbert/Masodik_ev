package szem2.gameCharactersAbstract;

public class TestCharacters {
    public static void main(String[] args) {
//        GameCharacter a = new GameCharacter() {
//            @Override
//            public void executeSkill() {
//            }
//        }
//      Absztrakt osztaly absztrakt metodusat ilyen modon is peldanyosithatjuk
        Druid a = new Druid("Feraldream", 80, "Cat Form");
        System.out.println(a);
        a.executeSkill();

    }
}
