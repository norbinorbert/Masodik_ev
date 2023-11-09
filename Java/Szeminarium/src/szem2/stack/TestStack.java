package szem2.stack;

public class TestStack{
    public static void main(String[] args) {
        Stack a = new Stack();
        a.pop();
        for(int i=1;i<10;i++){
            a.push(i);
        }
        System.out.println(a.pop());

        a.print();
    }
}
