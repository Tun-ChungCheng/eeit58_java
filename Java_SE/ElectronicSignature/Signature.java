package ElectronicSignature;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import java.awt.BorderLayout;
import java.awt.FlowLayout;

public class Signature extends JFrame {

    public static void main(String[] args) {
        new Signature();
    }

    private Signature(){
        super("Sign");
        Drawer drawer = new Drawer();

        setLayout(new BorderLayout());

        JButton clear = new JButton("Clear");
        JButton undo = new JButton("Undo");
        JButton redo = new JButton("Redo");
        JButton saveJPG = new JButton("Save to JPG");
        JButton saveLine = new JButton("Save Line");
        JButton loadLine = new JButton("Load Line");
        JPanel topPanel = new JPanel(new FlowLayout());

        topPanel.add(clear, FlowLayout.LEFT);
        topPanel.add(undo, FlowLayout.CENTER);
        topPanel.add(redo, FlowLayout.RIGHT);
        topPanel.add(saveJPG, FlowLayout.LEADING);
        topPanel.add(saveLine, FlowLayout.LEADING);
        topPanel.add(loadLine, FlowLayout.LEADING);

        add(topPanel, BorderLayout.NORTH);
        add(drawer, BorderLayout.CENTER);
        add(drawer.tcc, BorderLayout.SOUTH);

        clear.addActionListener(e -> drawer.clear());
        undo.addActionListener(e -> drawer.undo());
        redo.addActionListener(e -> drawer.redo());
        saveJPG.addActionListener(e -> drawer.save());
        saveLine.addActionListener(e -> drawer.saveLines());
        loadLine.addActionListener(e -> drawer.loadLines());

        setSize(1000, 1000);
        setVisible(true);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
    }
}
