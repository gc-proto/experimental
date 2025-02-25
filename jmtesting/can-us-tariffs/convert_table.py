from bs4 import BeautifulSoup
import re

def convert_table_row(html_string):
    # Parse the HTML
    soup = BeautifulSoup(html_string, 'html.parser')
    
    # Find the original cells
    cells = soup.find_all(['th', 'td'])
    
    if len(cells) < 3:
        return "Error: Input row doesn't have enough cells"
    
    # Extract the content from each cell
    tariff_item = cells[0].text.strip()
    hs_heading = cells[1].text.strip()
    description = str(cells[2])
    
    # Create a new row with the desired format
    new_row = BeautifulSoup('<tr></tr>', 'html.parser').tr
    
    # Create the tariff item cell
    tariff_td = soup.new_tag('td')
    tariff_td['data-label'] = 'Tariff Item'
    tariff_td.string = tariff_item
    new_row.append(tariff_td)
    
    # Create the HS heading cell
    hs_td = soup.new_tag('td')
    hs_td['data-label'] = 'Harmonized System (HS) Heading'
    span = soup.new_tag('span')
    span['class'] = 'text-left'
    span.string = hs_heading
    hs_td.append(span)
    new_row.append(hs_td)
    
    # Create the description cell
    desc_td = soup.new_tag('td')
    desc_td['data-label'] = 'Indicative Description'
    
    # If the original has a ul/li structure, preserve it
    if '<ul' in description:
        # Extract the ul element from the original
        ul_element = cells[2].find('ul')
        # Make sure the ul has the text-left class
        if ul_element:
            ul_element['class'] = 'text-left'
            desc_td.append(ul_element)
    else:
        # If no ul structure, just add the text
        desc_td.string = cells[2].text.strip()
    
    new_row.append(desc_td)
    
    # Return the formatted row with proper indentation
    return new_row.prettify()

def convert_entire_table(html_file_path, output_file_path):
    with open(html_file_path, 'r', encoding='utf-8') as file:
        html_content = file.read()
    
    # Extract all tr elements
    soup = BeautifulSoup(html_content, 'html.parser')
    all_rows = soup.find_all('tr')
    
    converted_rows = []
    for row in all_rows:
        converted_row = convert_table_row(str(row))
        converted_rows.append(converted_row)
    
    # Combine all converted rows
    table_html = f"<table>\n{''.join(converted_rows)}\n</table>"
    
    # Write to output file
    with open(output_file_path, 'w', encoding='utf-8') as file:
        file.write(table_html)
    
    return f"Converted {len(all_rows)} rows and saved to {output_file_path}"

# Example usage for a single row
sample_row = """
<tr>
    <th scope="row" class="fnt-nrml"><p>0105.11.22</p></th>
    <td><p>Live poultry, that is to say, fowls of the species Gallus domesticus, ducks, geese, turkeys and guinea fowls.</p></td>
    <td><ul class="text-left"><li>Weighing not more than 185&nbsp;g: Fowls of the species Gallus domesticus</li><li>Broilers for domestic production: Over access commitment</li></ul></td>
</tr>
"""

# Test the conversion on the sample row
print(convert_table_row(sample_row))

# To convert an entire file:
# print(convert_entire_table("input_table.html", "converted_table.html"))