import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

//Boda Norbert, 521
public class TextFilterFrame extends Frame {
    private TextField field;
    private Button filter;
    private TextArea area;

    public TextFilterFrame(){
        setBounds(200, 200, 500, 500);
        setTitle("Text Filter Frame");
        setLayout(new GridLayout(3, 1));
        addWindowListener(new WindowAdapter(){
            @Override
            public void windowClosing(WindowEvent e) {
                super.windowClosing(e);
                dispose();
            }
        });

        field = new TextField();
        add(field);

        filter = new Button("Filter");
        add(filter);

        area = new TextArea();
        add(area);

        filter.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                area.setText(area.getSelectedText().replace(field.getText(), ""));
            }
        });

        setVisible(true);
    }
}
