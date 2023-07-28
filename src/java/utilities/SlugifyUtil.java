/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import static java.awt.font.GlyphMetrics.WHITESPACE;
import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.text.ParseException;
import java.util.Locale;
import java.util.regex.Pattern;

/**
 *
 * @author MSII
 */
public class SlugifyUtil {
    private static final Pattern NONLATIN = Pattern.compile("[^\\w-]");
    private static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    public static String slugify(String input, int id) {
        if (input == null) {
            throw new IllegalArgumentException("Input cannot be null");
        }
        String nowhitespace = WHITESPACE.matcher(input).replaceAll("-");
        String normalized = Normalizer.normalize(nowhitespace, Form.NFD);
        String slug = NONLATIN.matcher(normalized).replaceAll("");
        slug = slug.toLowerCase(Locale.ENGLISH);
        return slug + "-" + id;
    }

    public static int getIdFormSlug(String slug) {
        int idNumber = Integer.parseInt(slug.split("-")[slug.split("-").length-1]);
        return idNumber;
    }
    public static void main(String[] args) {
        System.out.println("a");
    }
}
