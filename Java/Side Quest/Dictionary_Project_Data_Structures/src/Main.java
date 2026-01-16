

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.GridLayout;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JPasswordField;
import javax.swing.JScrollPane;
import javax.swing.JTextField;
import javax.swing.SwingConstants;



public class Main {

    public static final String GREEN = "\u001B[32m";
    public static final String RESET = "\u001B[0m";
    public static final String PINK = "\u001B[35m";
    public static final String RED = "\u001B[31m";
    
    
    private static JLabel wordLabel;
    private static JButton editExampleButton;
    private static JButton addWordButton;
    private static JButton deleteWorButton;
    private static JButton updateWordButton;

    private static JFrame allWordsFrame;
    private static JPanel showAllWordspanel;

    private static HashMap<String, DictionaryEntry> dictionaryMap = new HashMap<>();

    private static String lastSearchedWord = "";


    public static void main(String[] args) {
        loadDictionary();
        GUI();
    }
    

    private static class DictionaryEntry {
        String meaning;
        String example;
        String synonym;
        String antonym;
        String translation;
    
        DictionaryEntry(String meaning, String example, String translation, String synonym, String antonym) {
            this.meaning = meaning;
            this.example = example;
            this.synonym = synonym;
            this.antonym = antonym;
            this.translation = translation;
        }
    }
    
    private static void loadDictionary() {
        String filePath = "D:\\Codes\\Java\\Java School PROJECTS\\Dictionary_Project_Data_Structures\\src\\MARANAOWORDS.txt";

        int wordCount = 0;

        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(" - ");
                if (parts.length >= 2) {
                    String[] wordAndMeaning = parts[0].split(":", 2);
                    if (wordAndMeaning.length == 2) {
                        String word = wordAndMeaning[0].trim().toLowerCase();
                        String meaning = wordAndMeaning[1].trim();
    
                        String example = "No example provided";
                        String translation = "No translation provided";
                        String synonym = "No synonym provided";
                        String antonym = "No antonym provided";
    
                        if (parts.length > 1) {
                            String[] exampleParts = parts[1].split(":", 2);
                            if (exampleParts.length == 2) {
                                example = exampleParts[1].trim();
                            }
                        }
                        if (parts.length > 2) {
                            String[] translationParts = parts[2].split(":", 2);
                            if (translationParts.length == 2) {
                                translation = translationParts[1].trim();
                            }
                        }
                        if (parts.length > 3) {
                            String[] synonymParts = parts[3].split(":", 2);
                            if (synonymParts.length == 2) {
                                synonym = synonymParts[1].trim();
                            }
                        }
                        if (parts.length > 4) {
                            String[] antonymParts = parts[4].split(":", 2);
                            if (antonymParts.length == 2) {
                                antonym = antonymParts[1].trim();
                            }
                        }
    
                        dictionaryMap.put(word, new DictionaryEntry(meaning, example, translation, synonym, antonym));
                        wordCount++;
                        System.out.println("Loaded word: " + word);
                    }
                }
            }

            int needWord = 1000 - wordCount;
            if (wordCount >= 1000) {
                System.out.println(PINK + "YOU HAVE ACHIEVED 1000 WORDS");
                System.out.println(GREEN + "1000 WORDS LOADED SUCCESSFULLY");
            }

            else{
                System.out.println(PINK + "TOTAL WORDS LOADED: " + wordCount + "/1000");
                System.out.println(RED + "YOU NEED " + needWord + " WORDS TO ACHIEVE 1000 WORDS" + RESET);
            }

        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error loading dictionary file.");
        }
    }
    
    private static void GUI() {

        // -------------------------------------->Image Icon<--------------------------------------
        Image icon = Toolkit.getDefaultToolkit().getImage("D:\\Codes\\Dictionary_Project_Data_Structures\\src\\ICON.png");  

        // Get monitor size and set the frame based on the size of the monitor
        GraphicsEnvironment env = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice deviceSize = env.getDefaultScreenDevice();
        Rectangle bounds = deviceSize.getDefaultConfiguration().getBounds();
        
        int frameWidth = (int) (bounds.getWidth() * 0.9);
        int frameHeight = (int) (bounds.getHeight() * 0.9);

        // -------------------------------------->Frame<--------------------------------------
        JFrame frame = new JFrame("Maranao Dictionary");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(frameWidth, frameHeight);
        frame.setLocationRelativeTo(null);
        frame.setResizable(false);
        frame.getContentPane().setBackground(Color.WHITE);
        frame.setLayout(new BorderLayout());
        
        // Icon
        frame.setIconImage(icon);

        // Font size adjust based on monitor size
        int fontSize = (int) (bounds.getHeight() * 0.06); 

        // -------------------------------------->Title Label<--------------------------------------
        JLabel title = new JLabel("Maranao Dictionary", SwingConstants.CENTER);
        title.setFont(new Font("Times New Roman", Font.BOLD, fontSize));
        title.setForeground(Color.BLACK);
        title.setBorder(BorderFactory.createEmptyBorder(20, 0, 20, 0));

        // -------------------------------------->Search Field<--------------------------------------
        JTextField searchField = new JTextField();
        searchField.setHorizontalAlignment(JTextField.CENTER);

        // searchField font size adjust based on monitor size
        int fontSizeSeachField = (int) (bounds.getHeight() * 0.02); 
        searchField.setFont(new Font("Times New Roman", Font.PLAIN, fontSizeSeachField));

        // Set SearchField size based on monitor size
        searchField.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.2), (int) (bounds.getHeight() * 0.04)));

        // -------------------------------------->Search Button<--------------------------------------
        JButton searchButton = new JButton("Search");
        searchButton.setBackground(Color.WHITE);
        searchButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));
        
        // Update the performSearch to accept wordLabel
        searchButton.addActionListener(e -> performSearch(searchField, wordLabel));
        searchField.addActionListener(e -> searchButton.doClick());

        // -------------------------------------->Search Panel<--------------------------------------
        JPanel searchPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        searchPanel.setBackground(Color.WHITE);
        searchPanel.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.4), (int) (bounds.getHeight() * 0.1)));

        // Add components to search panel
        searchPanel.add(searchField);
        searchPanel.add(searchButton);

        // -------------------------------------->Side Panel<--------------------------------------
        JPanel sidePanel = new JPanel();
        sidePanel.setLayout(new FlowLayout(FlowLayout.CENTER));
        sidePanel.setBackground(Color.WHITE);
        sidePanel.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.BLACK, 1),
                BorderFactory.createEmptyBorder(10, 10, 10, 10)
        ));

        int panelHeight = (int) (bounds.getHeight() * 0.4); 
        sidePanel.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.1), panelHeight)); 
        sidePanel.setMaximumSize(new Dimension((int) (bounds.getWidth() * 0.1), panelHeight));

        // Invisible spacer (LEFT)
        JPanel westPanel = new JPanel();
        westPanel.setLayout(new BoxLayout(westPanel, BoxLayout.X_AXIS));
        westPanel.setBackground(Color.WHITE);
        westPanel.add(Box.createRigidArea(new Dimension(30, 0)));
        westPanel.add(sidePanel);

        // Invisible spacer (Right)
        JPanel eastPanel = new JPanel();
        eastPanel.setLayout(new BoxLayout(eastPanel, BoxLayout.X_AXIS));
        eastPanel.setBackground(Color.WHITE);
        eastPanel.add(Box.createRigidArea(new Dimension(223, 0)));

        // Invisible spacer (DOWN)
        JPanel southPanel = new JPanel();
        southPanel.setBackground(Color.WHITE);
        southPanel.setLayout(new BoxLayout(southPanel, BoxLayout.Y_AXIS));
        southPanel.add(Box.createRigidArea(new Dimension(0, 200)));

        // -------------------------------------->Side panel contents<--------------------------------------
        
        // additional settings label
        JLabel additionalSettings = new JLabel("Additional Settings", SwingConstants.CENTER);
        sidePanel.add(additionalSettings);

        // Edit button
        JButton editButton = new JButton("Edit Mode");
        editButton.setBackground(Color.WHITE);
        editButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(editButton);

        editButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        editButton.addActionListener(e -> {
            if (editButton.getText().equals("Edit Mode")) { 
                JFrame editFrame = new JFrame("Admin Access");
                editFrame.setSize((int) (bounds.getWidth() * 0.2), (int) (bounds.getHeight() * 0.2));
                editFrame.setLocationRelativeTo(null);
                editFrame.setResizable(false);
        
                JPanel formPanel = new JPanel(new GridLayout(3, 1, 15, 15));
                JTextField emailField = new JTextField();
                JPasswordField passField = new JPasswordField();
                formPanel.add(new JLabel("Email:"));
                formPanel.add(emailField);
                formPanel.add(new JLabel("Password:"));
                formPanel.add(passField);
        
                JButton submit = new JButton("Submit");
                editFrame.add(new JLabel("Sign in to use edit mode", SwingConstants.CENTER), BorderLayout.NORTH);
                editFrame.add(formPanel, BorderLayout.CENTER);
                editFrame.add(submit, BorderLayout.SOUTH);
                editFrame.setVisible(true);

                emailField.addActionListener(e2 -> submit.doClick());
                passField.addActionListener(e2 -> submit.doClick());
        
                submit.addActionListener(e2 -> {
                    String email = emailField.getText();
                    String pass = new String(passField.getPassword());
                    if (email.equals("admin") && pass.equals("admin")) {
                        editFrame.setVisible(false);
                        editFrame.dispose();
                        editButton.setText("View Mode");
                        addWordButton.setVisible(true);
                        deleteWorButton.setVisible(true);
                        updateWordButton.setVisible(true);

                    } else {
                        JOptionPane.showMessageDialog(null, "Invalid email or password", "Error", JOptionPane.ERROR_MESSAGE);
                        editButton.setText("Edit Mode");
                        addWordButton.setVisible(false);
                        deleteWorButton.setVisible(false);
                        updateWordButton.setVisible(false);
                    }
                });
            } else {
                editButton.setText("Edit Mode");
                addWordButton.setVisible(false);
                deleteWorButton.setVisible(false);
                updateWordButton.setVisible(false);
            }
        });
        


        // Add word button
        addWordButton = new JButton("Add Word");
        addWordButton.setBackground(Color.WHITE);
        addWordButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(addWordButton);
        addWordButton.setVisible(false);

        addWordButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        addWordButton.addActionListener(e -> {
            addWordToDictionary();
        });

        // Delete word button
        deleteWorButton = new JButton("Delete Word");
        deleteWorButton.setBackground(Color.WHITE);
        deleteWorButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(deleteWorButton);
        deleteWorButton.setVisible(false);

        deleteWorButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        deleteWorButton.addActionListener(e -> {
            deleteWordFromDictionary();
        });

        // update word button
        updateWordButton = new JButton("Update Word");
        updateWordButton.setBackground(Color.WHITE);
        updateWordButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(updateWordButton);
        updateWordButton.setVisible(false);

        updateWordButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        updateWordButton.addActionListener(e -> {
            updateWordInDictionary();
        });
        
        // -------------------------------------->Top Panel (Container for Title and Search Panel)<--------------------------------------
        JPanel topPanel = new JPanel(new BorderLayout()); 
        topPanel.setBackground(Color.WHITE);

        topPanel.add(title, BorderLayout.CENTER);
        topPanel.add(searchPanel, BorderLayout.SOUTH);

        frame.add(topPanel, BorderLayout.NORTH);

        // -------------------------------------->Content Panel<--------------------------------------
        JPanel contentPanel = new JPanel(new BorderLayout()); // Use BorderLayout for easy alignment
        contentPanel.setBackground(Color.WHITE);

        JPanel labelPanel = new JPanel();
        labelPanel.setLayout(new BoxLayout(labelPanel, BoxLayout.Y_AXIS));
        labelPanel.setBackground(Color.white);

        int topPadding = 30;
        labelPanel.add(Box.createRigidArea(new Dimension(0, topPadding)));

        int leftPadding = 130;
        labelPanel.add(Box.createRigidArea(new Dimension(leftPadding, 0)));

        wordLabel = new JLabel(); 
        wordLabel.setFont(new Font("Times New Roman", Font.PLAIN, fontSizeSeachField));
        wordLabel.setForeground(Color.BLACK); 

        labelPanel.add(wordLabel);
        contentPanel.add(labelPanel, BorderLayout.NORTH);
        frame.add(contentPanel, BorderLayout.CENTER);

        // edit Sentence button
        editExampleButton = new JButton("Edit Sentence");
        editExampleButton.setPreferredSize(new Dimension(150, 40));
        editExampleButton.setBackground(Color.WHITE);
        editExampleButton.setVisible(false);
        editExampleButton.setBorder(BorderFactory.createEmptyBorder(20, 0, 0, 0));
        editExampleButton.setForeground(Color.BLUE);
        editExampleButton.setFont(new Font("Arial", Font.PLAIN, 13));
        editExampleButton.setFocusable(false);
        editExampleButton.setContentAreaFilled(false);

        labelPanel.add(editExampleButton);
        
        editExampleButton.addActionListener(e -> {
            if (editButton.getText().equals("View Mode")) {
        
                if (lastSearchedWord.isEmpty()) {
                    JOptionPane.showMessageDialog(null, "No word has been searched yet.", "Error", JOptionPane.ERROR_MESSAGE);
                    return;
                }
        
                DictionaryEntry currentEntry = dictionaryMap.get(lastSearchedWord);
                
                JPanel editPanel = new JPanel(new GridLayout(2, 2));
                JTextField exampleField = new JTextField(currentEntry.example);
                JTextField translationField = new JTextField(currentEntry.translation);
                
                editPanel.add(new JLabel("Edit Sentence:"));
                editPanel.add(exampleField);
                editPanel.add(new JLabel("Edit Translation:"));
                editPanel.add(translationField);
                
                int option = JOptionPane.showConfirmDialog(null, editPanel, "Edit Sentence and Translation", JOptionPane.OK_CANCEL_OPTION);
                
                if (option == JOptionPane.OK_OPTION) {
                    currentEntry.example = exampleField.getText();
                    currentEntry.translation = translationField.getText();
                
                    saveDictionary();
                
                    JOptionPane.showMessageDialog(null, "Successfully saved the edited example!", "Success", JOptionPane.INFORMATION_MESSAGE);
                
                    performSearch(new JTextField(lastSearchedWord), wordLabel);
                }
        
            } else {
                JOptionPane.showMessageDialog(null, "Edit mode is only available for Editors.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        });

        // all words button
        JButton allWordsButton = new JButton("Show All Words");
        allWordsButton.setBackground(Color.WHITE);
        allWordsButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(allWordsButton);

        allWordsButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        allWordsButton.addActionListener(e -> {
            if (allWordsButton.getText().equals("Show All Words")) {
                allWordsButton.setText("Hide All Words");
                showAllWords();
            }
            else {
                allWordsButton.setText("Show All Words");
                if (allWordsFrame != null) {
                    hideAllWords();
                }
            }
        });

        
        // dark mode button
        JButton darkModeButton = new JButton("Dark Mode");
        darkModeButton.setBackground(Color.LIGHT_GRAY);
        darkModeButton.setPreferredSize(new Dimension(150, 30));
        sidePanel.add(darkModeButton, BorderLayout.SOUTH);

        darkModeButton.setPreferredSize(new Dimension((int) (bounds.getWidth() * 0.093), (int) (bounds.getHeight() * 0.03)));

        darkModeButton.addActionListener(e -> {
            if (darkModeButton.getText().equals("Dark Mode")) {
                darkModeButton.setText("Light Mode");
        
                // Change the background color to dark mode
                
                // search field
                searchField.setBackground(Color.LIGHT_GRAY); 
                searchField.setCursor(new Cursor(Cursor.TEXT_CURSOR));
                
                // buttons
                searchButton.setBackground(Color.LIGHT_GRAY);
                allWordsButton.setBackground(Color.LIGHT_GRAY);
                darkModeButton.setBackground(Color.WHITE);
                editExampleButton.setForeground(Color.GREEN);
                addWordButton.setBackground(Color.LIGHT_GRAY);
                deleteWorButton.setBackground(Color.LIGHT_GRAY);
                editButton.setBackground(Color.LIGHT_GRAY);
                updateWordButton.setBackground(Color.LIGHT_GRAY);

                // title
                title.setForeground(Color.WHITE);
                additionalSettings.setForeground(Color.WHITE);

                // frame
                frame.getContentPane().setBackground(Color.DARK_GRAY);

                // Panels
                westPanel.setBackground(Color.DARK_GRAY);
                southPanel.setBackground(Color.DARK_GRAY);
                sidePanel.setBackground(Color.DARK_GRAY);
                searchPanel.setBackground(Color.DARK_GRAY);
                labelPanel.setBackground(Color.DARK_GRAY);
                topPanel.setBackground(Color.DARK_GRAY);
                eastPanel.setBackground(Color.DARK_GRAY);
                contentPanel.setBackground(Color.DARK_GRAY);

                // Label
                wordLabel.setForeground(Color.WHITE);

                // border
                sidePanel.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.WHITE, 1),
                BorderFactory.createEmptyBorder(10, 10, 10, 10)
                ));
        
            }
            
            else {
                darkModeButton.setText("Dark Mode");
                
                // Revert back to light mode
                
                // search field
                searchField.setBackground(Color.WHITE);

                // buttons
                searchButton.setBackground(Color.WHITE);
                allWordsButton.setBackground(Color.WHITE);
                darkModeButton.setBackground(Color.LIGHT_GRAY);
                editExampleButton.setForeground(Color.BLUE);
                addWordButton.setBackground(Color.WHITE);
                deleteWorButton.setBackground(Color.WHITE);

                // title
                title.setForeground(Color.BLACK);
                additionalSettings.setForeground(Color.BLACK);

                // frame
                frame.getContentPane().setBackground(Color.WHITE);
        
                // Revert panels
                westPanel.setBackground(Color.WHITE);
                southPanel.setBackground(Color.WHITE);
                searchPanel.setBackground(Color.WHITE);
                sidePanel.setBackground(Color.WHITE);
                labelPanel.setBackground(Color.WHITE);
                topPanel.setBackground(Color.WHITE);
                eastPanel.setBackground(Color.WHITE);
                contentPanel.setBackground(Color.WHITE);
                editButton.setBackground(Color.WHITE);
                updateWordButton.setBackground(Color.WHITE);

                // Label
                wordLabel.setForeground(Color.BLACK);

                // border
                sidePanel.setBorder(BorderFactory.createCompoundBorder(
                BorderFactory.createLineBorder(Color.BLACK, 1),
                BorderFactory.createEmptyBorder(10, 10, 10, 10)
                ));
                
            }
        });

        /// -------------------------------------->Add panels to frame<--------------------------------------
        frame.add(topPanel, BorderLayout.NORTH);  
        frame.add(contentPanel, BorderLayout.CENTER);  
        frame.add(westPanel, BorderLayout.WEST);
        frame.add(eastPanel, BorderLayout.EAST);
        frame.setVisible(true);

    }
    
        /// -------------------------------------->GAMIT SA SEARCH BUTTON AT FIELD<--------------------------------------
        private static void performSearch(JTextField searchField, JLabel wordLabel) {
            String searchedWord = searchField.getText().trim(); 
            searchedWord = searchedWord.toLowerCase();
            
            System.out.println(GREEN + "Search for: " + RESET + searchedWord);
        
            if (searchedWord.length() < 3) {
                wordLabel.setText("<html><b>No results found for: </b>" + searchedWord + "</html>");
                editExampleButton.setVisible(false);
                return;
            }
        
            boolean found = false;
        
            for (String key : dictionaryMap.keySet()) {
                DictionaryEntry entry = dictionaryMap.get(key);
                
                if (key.equalsIgnoreCase(searchedWord)) {
                    found = true; 
                    wordLabel.setText("<html><span style='font-size:35px;'><b>\"" + key + "\"</b></span>" +
                    "<br>" + entry.meaning + 
                    "<div style='margin-top:10px;'><span style='font-size:20px;'><b>Synonyms: </b></span>" + entry.synonym + "</div>" +
                    "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Antonyms: </b></span>" + entry.antonym + "</div>" +
                    "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Word in a sentence: </b></span>" + entry.example + "</div>" +
                    "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Sentence translation: </b></span>" + entry.translation + "</div></html>");
                    
                    lastSearchedWord = key; 
                    editExampleButton.setVisible(true);
                    return;
                }
            }
        
            for (String key : dictionaryMap.keySet()) {
                DictionaryEntry entry = dictionaryMap.get(key);
                
                String cleanedMeaning = entry.meaning.replaceAll("[;,.]", "").toLowerCase(); // Remove ;, ., and ,
                
                String[] meaningWords = cleanedMeaning.split("\\s+");
                for (String word : meaningWords) {
                    if (word.equals(searchedWord)) {
                        found = true;
                        wordLabel.setText("<html><span style='font-size:35px;'><b>\"" + key + "\"</b></span>" +
                        "<br>" + entry.meaning + 
                        "<div style='margin-top:10px;'><span style='font-size:20px;'><b>Synonyms: </b></span>" + entry.synonym + "</div>" +
                        "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Antonyms: </b></span>" + entry.antonym + "</div>" +
                        "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Word in a sentence: </b></span>" + entry.example + "</div>" +
                        "<div style='margin-top:8px;'><span style='font-size:20px;'><b>Sentence translation: </b></span>" + entry.translation + "</div></html>");
                        
                        lastSearchedWord = key; 
                        editExampleButton.setVisible(true);
                        return;
                    }
                }
            }
        
            if (!found) {
                wordLabel.setText("<html><b>No results found for: </b>" + searchedWord + "</html>");
                editExampleButton.setVisible(false);
            }
        }
        
        /// -------------------------------------->SAVE SA TXT FILE<--------------------------------------

    private static void saveDictionary() {
        String filePath = "D:\\Codes\\Java\\Java School PROJECTS\\Dictionary_Project_Data_Structures\\src\\MARANAOWORDS.txt";
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filePath))) {
            List<String> sortedKeys = new ArrayList<>(dictionaryMap.keySet());
            Collections.sort(sortedKeys);
            for (String word : sortedKeys) {
                DictionaryEntry entry = dictionaryMap.get(word);
                bw.write(word + ":" +
                        entry.meaning + " - Example:" +
                        entry.example + " - Translation:" +
                        entry.translation + " - Synonyms:" +
                        entry.synonym + " - Antonyms:" +
                        entry.antonym);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(null, "Error saving dictionary file: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

        /// -------------------------------------->ADD WORD<--------------------------------------
    private static void addWordToDictionary() {

        JPanel panel = new JPanel(new GridLayout(0, 2));
        JTextField wordField = new JTextField();
        JTextField meaningField = new JTextField();
        JTextField exampleField = new JTextField();
        JTextField translationField = new JTextField();
        JTextField synonymsField = new JTextField();
        JTextField antonymsField = new JTextField();
    
        panel.add(new JLabel("Word:"));
        panel.add(wordField);
        panel.add(new JLabel("Meaning:"));
        panel.add(meaningField);
        panel.add(new JLabel("Example:"));
        panel.add(exampleField);
        panel.add(new JLabel("Translation:"));
        panel.add(translationField);
        panel.add(new JLabel("Synonyms (comma-separated):"));
        panel.add(synonymsField);
        panel.add(new JLabel("Antonyms (comma-separated):"));
        panel.add(antonymsField);
    
        int result = JOptionPane.showConfirmDialog(null, panel, "Add New Word", JOptionPane.OK_CANCEL_OPTION);
        if (result == JOptionPane.OK_OPTION) {

            String newWord = wordField.getText().trim();
            String meaning = meaningField.getText().trim();
            String example = exampleField.getText().trim();
            String translation = translationField.getText().trim();
            String synonyms = synonymsField.getText().trim();
            String antonyms = antonymsField.getText().trim();
    
            if (dictionaryMap.containsKey(newWord.toLowerCase())) {
                JOptionPane.showMessageDialog(null, "Word already exists in the dictionary.", "Error", JOptionPane.ERROR_MESSAGE);
                return;
            }
    
            DictionaryEntry newEntry = new DictionaryEntry(meaning, example, translation, synonyms, antonyms);
            newEntry.meaning = meaning;
            newEntry.example = example;
            newEntry.translation = translation;
            newEntry.synonym = synonyms;
            newEntry.antonym = antonyms;
    
            dictionaryMap.put(newWord.toLowerCase(), newEntry);
    
            saveDictionary();
    
            JOptionPane.showMessageDialog(null, "Word added successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
        } else {
            JOptionPane.showMessageDialog(null, "Operation canceled.", "Information", JOptionPane.INFORMATION_MESSAGE);
        }
    }

        /// -------------------------------------->UPDATE WORD<--------------------------------------
        private static void updateWordInDictionary() {
            JPanel panel = new JPanel(new BorderLayout());

            JTextField searchField = new JTextField();
            panel.add(searchField, BorderLayout.NORTH);

            DefaultListModel<String> listModel = new DefaultListModel<>();
            dictionaryMap.keySet().stream()
                .sorted()
                .forEach(listModel::addElement);

            JList<String> wordList = new JList<>(listModel);
            JScrollPane scrollPane = new JScrollPane(wordList);
            panel.add(scrollPane, BorderLayout.CENTER);

            JDialog dialog = new JDialog();
            dialog.setTitle("Update Word");
            dialog.setContentPane(panel);
            dialog.setModal(true);
            dialog.setSize(400, 300);
            dialog.setLocationRelativeTo(null);

            searchField.addKeyListener(new KeyAdapter() {
                @Override
                public void keyReleased(KeyEvent e) {
                    String searchText = searchField.getText().toLowerCase();
                    listModel.clear();

                    dictionaryMap.entrySet().stream()
                        .filter(entry -> 
                            entry.getKey().toLowerCase().contains(searchText) || 
                            entry.getValue().meaning.toLowerCase().contains(searchText))
                        .map(Map.Entry::getKey)
                        .sorted() 
                        .forEach(listModel::addElement);         }
            });

            JButton selectButton = new JButton("Select");
            selectButton.addActionListener(e -> {
                String selectedWord = wordList.getSelectedValue();
                if (selectedWord != null) {

                    dialog.dispose();
                    DictionaryEntry entry = dictionaryMap.get(selectedWord.toLowerCase());

                    JPanel updatePanel = new JPanel(new GridLayout(0, 2));
                    JTextField wordField = new JTextField(selectedWord);
                    JTextField meaningField = new JTextField(entry.meaning);
                    JTextField exampleField = new JTextField(entry.example);
                    JTextField translationField = new JTextField(entry.translation);
                    JTextField synonymsField = new JTextField(entry.synonym);
                    JTextField antonymsField = new JTextField(entry.antonym);

                    updatePanel.add(new JLabel("Word:"));
                    updatePanel.add(wordField);
                    updatePanel.add(new JLabel("Meaning:"));
                    updatePanel.add(meaningField);
                    updatePanel.add(new JLabel("Example:"));
                    updatePanel.add(exampleField);
                    updatePanel.add(new JLabel("Translation:"));
                    updatePanel.add(translationField);
                    updatePanel.add(new JLabel("Synonyms (comma-separated):"));
                    updatePanel.add(synonymsField);
                    updatePanel.add(new JLabel("Antonyms (comma-separated):"));
                    updatePanel.add(antonymsField);

                    int result = JOptionPane.showConfirmDialog(null, updatePanel, "Update Word", JOptionPane.OK_CANCEL_OPTION);
                    if (result == JOptionPane.OK_OPTION) {

                        String newMeaning = meaningField.getText().trim();
                        String newExample = exampleField.getText().trim();
                        String newTranslation = translationField.getText().trim();
                        String newSynonyms = synonymsField.getText().trim();
                        String newAntonyms = antonymsField.getText().trim();

                        DictionaryEntry updatedEntry = new DictionaryEntry(newMeaning, newExample, newTranslation, newSynonyms, newAntonyms);
                        dictionaryMap.put(selectedWord.toLowerCase(), updatedEntry);

                        saveDictionary();

                        JOptionPane.showMessageDialog(null, "Word updated successfully!", "Success", JOptionPane.INFORMATION_MESSAGE);
                    }
                } else {
                    JOptionPane.showMessageDialog(null, "Please select a word to update.", "Warning", JOptionPane.WARNING_MESSAGE);
                }
            });

            panel.add(selectButton, BorderLayout.SOUTH);

            dialog.setVisible(true);
        }

        /// -------------------------------------->DELETE WORD<--------------------------------------
        private static void deleteWordFromDictionary() {
            JPanel panel = new JPanel(new BorderLayout());
        
            JTextField searchField = new JTextField();
            panel.add(searchField, BorderLayout.NORTH);
        
            DefaultListModel<String> listModel = new DefaultListModel<>();
            dictionaryMap.keySet().stream()
                .sorted()
                .forEach(listModel::addElement);
        
            JList<String> wordList = new JList<>(listModel);
            JScrollPane scrollPane = new JScrollPane(wordList);
            panel.add(scrollPane, BorderLayout.CENTER);
        
            JDialog dialog = new JDialog();
            dialog.setTitle("Delete Word");
            dialog.setContentPane(panel);
            dialog.setModal(true);
            dialog.setSize(400, 300);
            dialog.setLocationRelativeTo(null);
        
            searchField.addKeyListener(new KeyAdapter() {
                @Override
                public void keyReleased(KeyEvent e) {
                    String searchText = searchField.getText().toLowerCase();
                    listModel.clear();
                    dictionaryMap.entrySet().stream()
                        .filter(entry -> entry.getKey().toLowerCase().contains(searchText) || 
                                        entry.getValue().meaning.toLowerCase().contains(searchText))
                        .map(Map.Entry::getKey)
                        .sorted()
                        .forEach(listModel::addElement);
                }
            });
        
            JButton deleteButton = new JButton("Delete");
            deleteButton.addActionListener(e -> {
                String selectedWord = wordList.getSelectedValue();
                if (selectedWord != null) {
                    int confirmResult = JOptionPane.showConfirmDialog(dialog, 
                        "Are you sure you want to delete the word '" + selectedWord + "'?", 
                        "Confirm Deletion", JOptionPane.YES_NO_OPTION);
                    if (confirmResult == JOptionPane.YES_OPTION) {
                        dictionaryMap.remove(selectedWord.toLowerCase());
                        saveDictionary();
                        JOptionPane.showMessageDialog(dialog, "Word '" + selectedWord + "' deleted successfully!", 
                                "Success", JOptionPane.INFORMATION_MESSAGE);
                        dialog.dispose();
                    }
                } else {
                    JOptionPane.showMessageDialog(dialog, "Please select a word to delete.", 
                            "Warning", JOptionPane.WARNING_MESSAGE);
                }
            });
        
            panel.add(deleteButton, BorderLayout.SOUTH);
        
            dialog.setVisible(true);
        }
        
        /// -------------------------------------->show all words (GAMIT SA SHOW ALL BUTTN)<--------------------------------------
    private static void showAllWords() {
        
        GraphicsEnvironment env = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice deviceSize = env.getDefaultScreenDevice();
        Rectangle bounds = deviceSize.getDefaultConfiguration().getBounds();
        
        int frameWidth = (int) (bounds.getWidth() * 0.5);
        int frameHeight = (int) (bounds.getHeight() * 0.5);
        
        if (allWordsFrame == null) {
            allWordsFrame = new JFrame("All Words");
            allWordsFrame.setSize(frameWidth, frameHeight);
            allWordsFrame.setLocationRelativeTo(null);
            allWordsFrame.setUndecorated(true);
            allWordsFrame.setAlwaysOnTop(true);
    
            showAllWordspanel = new JPanel();
            showAllWordspanel.setLayout(new BoxLayout(showAllWordspanel, BoxLayout.Y_AXIS));
    
            List<String> sortedKeys = new ArrayList<>(dictionaryMap.keySet());
            Collections.sort(sortedKeys);
    
            for (String key : sortedKeys) {
                DictionaryEntry entry = dictionaryMap.get(key);
                
                JLabel wordLabel = new JLabel("<html><span style='font-size:15px;'><b>" + key + "</b></span>" +
                        "<br><span style='font-size:10px;'>" + entry.meaning + "</span>" + 
                        "<div style='margin-top:4px;'><b><span style='font-size:10px;'>Synonyms: </span></b>" + 
                            entry.synonym + "</div>" +
                        "<div style='margin-top:4px;'><b><span style='font-size:10px;'>Antonyms: </span></b>" + 
                            entry.antonym + "</div>" +
                        "<div style='margin-top:4px;'><b><span style='font-size:10px;'>Word in a sentence: </span></b>" + 
                            entry.example + "</div>" +
                        "<div style='margin-top:4px;'><b><span style='font-size:10px;'>Sentence translation: </span></b>" + 
                            entry.translation + "</div></html>");
                wordLabel.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));


                
                showAllWordspanel.add(wordLabel);
            }
    
            allWordsFrame.add(new JScrollPane(showAllWordspanel));
            allWordsFrame.setVisible(true);
        } else {
            allWordsFrame.setVisible(true);
        }
    }
    
        /// -------------------------------------->hide all words (gamit sa SHOW ALL BUTTON)<--------------------------------------
    private static void hideAllWords() {
        if (allWordsFrame != null) {
            allWordsFrame.dispose();
            allWordsFrame = null;
            showAllWordspanel = null;
        }
    }

}