import QtQuick 2.6
import StratifyLabs.UI 2.0

SContainer {
    name: "Attributes";
    style: "fill";
    SPane {
        style: "block fill";
        SColumn {
            SText { style: "left text-bold text-lg"; text: "Introduction"; }
            SText { style: "block"; text: 'StratifyLabs UI allows you to quickly layout and style QML applications. It \
does this by attaching an "SAttributes" object to each item that defines the size and color scheme of each object. \
There are two ways to change an objects attributes: 1) using "style" 2) directly using "attr".'; }
            SText { style: "block"; text: 'Additionally, each item has quick access to "span" which \
defines the width of an S{Object} in an SRow. The code looks like this:'; }

            SWell {
                text: 'property alias style: attr.style;
property alias span: attr.span;
property alias attr: attr;
SAttributes {
    id: attr;
    type: "button";
}
';
            }

            SText { style: "block"; text: 'Most S{Objects} use SAttributes as the "attr" object. \
S{Objects} that don\'t have any color (e.g. SPane) use SSizeAttributes (which SAttributes inherits). If an object \
has additional attibutes, the object will be S{Object}Attributes (such as SAlertAttributes).'; }

            SText { style: "left text-bold text-lg"; text: "Changing the Style"; }
            SText { style: "block"; text: 'When a new value is assigned to the "style" property, \
the string is parsed and the styling is bound to the object.'; }
            SText { style: "block text-bold"; text: 'SSizeAttributes'; }
            SText { style: "block"; text: 'SSizeAttributes (all objects) support the following style \
options.'; }

            SContainer {
                SColumn {
                    SText { style: "left text-bold"; text: "Padding"; }
                    ElementBullet { text: "padding-zero"; }
                    ElementBullet { text: "padding-xs"; }
                    ElementBullet { text: "padding-lg"; }

                    SHLine {}

                    SText { style: "left text-bold"; text: "Horizontal Alignment"; }
                    ElementBullet { text: "left"; }
                    ElementBullet { text: "right"; }
                    ElementBullet { text: "center"; }

                    SText { style: "left text-bold"; text: "Vertical Alignment"; }
                    ElementBullet { text: "top"; }
                    ElementBullet { text: "bottom"; }
                    ElementBullet { text: "middle"; }

                    AttributeExampleAlignment{}
                    CodeExample { source: "AttributeExampleAlignment"; }

                    SHLine {}


                    SText { style: "left text-bold"; text: "Sizing"; }
                    ElementBullet { text: "fill: fill height"; }
                    ElementBullet { text: "block: fill width"; }
                    ElementBullet { text: "default: align middle-center, implicit size"; }

                    AttributeExampleSize{}
                    CodeExample { source: "AttributeExampleSize"; }
                }
            }

            SText { style: "block text-bold"; text: 'SAttributes'; }
            SText { style: "block"; text: 'SAttributes (most objects) support the following style \
options.'; }

            SContainer {
                SColumn {
                    SText { style: "left text-bold"; text: "Size"; }
                    SText { style: "left text-sm"; text: "Changes text size and padding"; }
                    ElementBullet { text: "xs"; }
                    ElementBullet { text: "sm"; }
                    ElementBullet { text: "lg"; }

                    SHLine {}

                    SText { style: "left text-bold"; text: "Text Sizes"; }
                    ElementBullet { text: "text-h1"; }
                    ElementBullet { text: "text-h2"; }
                    ElementBullet { text: "text-h3"; }
                    ElementBullet { text: "text-h4"; }
                    ElementBullet { text: "text-h5"; }
                    ElementBullet { text: "text-h6"; }
                    ElementBullet { text: "text-sm"; }
                    ElementBullet { text: "text-lg"; }

                    AttributeExampleTextSize{}
                    CodeExample { source: "AttributeExampleTextSize"; }

                    SHLine {}

                    SText { style: "left text-bold"; text: "Text Alignment"; }

                    ElementBullet { text: "text-right"; }
                    ElementBullet { text: "text-left"; }
                    ElementBullet { text: "text-center"; }
                    ElementBullet { text: "text-top"; }
                    ElementBullet { text: "text-bottom"; }
                    ElementBullet { text: "text-middle"; }

                    AttributeExampleTextAlignment{}
                    CodeExample { source: "AttributeExampleTextAlignment"; }

                    SHLine {}

                    SText { style: "left text-bold"; text: "Text Weight"; }
                    ElementBullet { text: "text-bold"; }
                    ElementBullet { text: "text-light"; }
                    ElementBullet { text: "text-demi-bold"; }
                    ElementBullet { text: "text-extra-bold"; }
                    ElementBullet { text: "text-extra-light"; }
                    SRow {
                        SText { span: 4; style: "text-bold"; text: "Text Bold"; }
                        SText { span: 4; style: "text-light"; text: "Text Light"; }
                        SText { span: 4; style: "text-demi-bold"; text: "Text Demi Bold"; }
                        SText { span: 4; style: "text-extra-bold"; text: "Text Extra Bold"; }
                        SText { span: 4; style: "text-extra-ligh"; text: "Text Extra Light"; }
                        SText { span: 4; text: "Text"; }
                    }

                    SHLine {}
                    SText { style: "left text-bold"; text: "Text Color"; }

                    ElementBullet { text: "text-on-primary: color when on primary"; }
                    ElementBullet { text: "text-on-secondary: color when on secondary"; }
                    ElementBullet { text: "text-on-info: color when on info"; }
                    ElementBullet { text: "text-on-warning: color when on warning"; }
                    ElementBullet { text: "text-on-danger: color when on danger"; }
                    ElementBullet { text: "text-on-success: color when on success"; }
                    ElementBullet { text: "text-primary: set text color to primary"; }
                    ElementBullet { text: "text-secondary: set text color to secondary"; }
                    ElementBullet { text: "text-info: set text color to info"; }
                    ElementBullet { text: "text-warning: set text color to warning"; }
                    ElementBullet { text: "text-danger: set text color to danger"; }
                    ElementBullet { text: "text-success: set text color to success"; }


                    SHLine {}

                    SText { style: "left text-bold"; text: "Color Schemes"; }
                    SText { style: "left text-sm"; text: "Change font, object, and border colors"; }
                    ElementBullet { text: "primary"; }
                    ElementBullet { text: "secondary"; }
                    ElementBullet { text: "info"; }
                    ElementBullet { text: "warning"; }
                    ElementBullet { text: "danger"; }
                    ElementBullet { text: "success"; }
                }
            }

            SText { style: "block"; text: 'Each S{Object} may add additional styling options. For example \
SButton uses "btn-outline-primary" for setting the color.'; }


            SText { style: "left text-bold text-lg"; text: "Further Customization"; }

            SText { style: "block"; text: 'If the styling options above don\'t meet your needs, \
you can directly access an item\'s attributes using the "attr" property. This is useful if you want \
to bind to specific attributes. The following example binds the icon "spin" attribute to a variable.'; }

            AttributeExampleCustomAttributes{}
            CodeExample { source: "AttributeExampleCustomAttributes"; }
        }

    }
}
