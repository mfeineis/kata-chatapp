module App.UI exposing
    ( ButtonModifier(..)
    , PillModifier(..)
    , button
    , detailPanel
    , layout
    , layoutContent
    , mainContent
    , menuEntry
    , menuEntryIcon
    , menuEntryLabel
    , panelContent
    , panelMenu
    , panelMenuFooter
    , panelMenuHeader
    , panelMenuMenu
    , panelMenuSpacing
    , panelMenuTextfield
    , panelMenuTitle
    , pill
    , streamItem
    , streamItemHighlighted
    , streamItemIcon
    , streamItemLabel
    , streamItemSub
    , threadPanel
    , toolPanel
    , toolPanelItem
    , toolPanelItems
    , toolPanelMenu
    , toolPanelMenuFloating
    , toolPanelTools
    )

import Css exposing (..)
import Css.Global exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Styled


type Block
    = Button ButtonModifier
    | DetailPanel
    | Layout
    | LayoutContent
    | MainContent
    | MenuEntry MenuEntryElement
    | PanelContent
    | PanelMenuFooter
    | PanelMenuHeader
    | PanelMenu PanelMenuElement
    | Pill PillModifier
    | StreamItem MenuEntryElement
    | StreamItemHighlighted
    | StreamItemSub
    | ThreadPanel
    | ToolPanelMenuFloating
    | ToolPanelMenu
    | ToolPanel ToolPanelElement


type ButtonModifier
    = DefaultButton
    | IconButton
    | LargeButton
    | PrimaryButton
    | SmallButton


type MenuEntryElement
    = Default
    | Icon
    | Label


type PanelMenuElement
    = DefaultPanelMenu
    | Menu
    | Spacing
    | Textfield
    | Title


type PillModifier
    = DefaultPill
    | InlinePill
    | PrimaryPill
    | SupPill


type ToolPanelElement
    = DefaultToolPanel
    | Item
    | Items
    | Tools


toClassNames : Block -> List String
toClassNames block =
    (case block of
        Button DefaultButton ->
            [ "btn" ]

        Button IconButton ->
            [ "btn", "btn--icon" ]

        Button LargeButton ->
            [ "btn", "btn--lg" ]

        Button PrimaryButton ->
            [ "btn", "btn--primary" ]

        Button SmallButton ->
            [ "btn", "btn--sm" ]

        DetailPanel ->
            [ "detail-panel" ]

        Layout ->
            [ "layout" ]

        LayoutContent ->
            [ "layout-content" ]

        MainContent ->
            [ "main-content" ]

        MenuEntry Default ->
            [ "menu-entry" ]

        MenuEntry Icon ->
            [ "menu-icon__icon" ]

        MenuEntry Label ->
            [ "menu-icon__label" ]

        PanelContent ->
            [ "panel-content" ]

        PanelMenuFooter ->
            [ "panel-menu", "panel-menu--footer" ]

        PanelMenuHeader ->
            [ "panel-menu", "panel-menu--header" ]

        PanelMenu DefaultPanelMenu ->
            [ "panel-menu" ]

        PanelMenu Menu ->
            [ "panel-menu__menu" ]

        PanelMenu Spacing ->
            [ "panel-menu__spacing" ]

        PanelMenu Textfield ->
            [ "panel-menu__textfield" ]

        PanelMenu Title ->
            [ "panel-menu__title" ]

        Pill DefaultPill ->
            [ "pill" ]

        Pill InlinePill ->
            [ "pill-inline" ]

        Pill PrimaryPill ->
            [ "pill", "pill--primary" ]

        Pill SupPill ->
            [ "pill", "pill--sup" ]

        StreamItem Default ->
            [ "stream-item" ]

        StreamItem Icon ->
            [ "stream-item__icon" ]

        StreamItem Label ->
            [ "stream-item__label" ]

        StreamItemHighlighted ->
            [ "stream-item", "stream-item--highlighted" ]

        StreamItemSub ->
            [ "stream-item", "stream-item--sub" ]

        ThreadPanel ->
            [ "thread-panel" ]

        ToolPanel DefaultToolPanel ->
            [ "tool-panel" ]

        ToolPanel Item ->
            [ "tool-panel__item" ]

        ToolPanel Items ->
            [ "tool-panel__items" ]

        ToolPanel Tools ->
            [ "tool-panel__tools" ]

        ToolPanelMenu ->
            [ "tool-panel__menu" ]

        ToolPanelMenuFloating ->
            [ "tool-panel__menu", "tool-panel__menu--floating" ]

     ) |> List.map (\it -> "ui-" ++ it)


toClassName : Block -> String
toClassName block =
    toClassNames block
        |> List.reverse
        |> List.head
        |> Maybe.withDefault ""


globalStyles : Html msg
globalStyles =
    Css.Global.global
        [ class (toClassName (Button DefaultButton))
            [ backgroundColor (hex "f0f0f0")
            , border3 (px 1) solid (hex "eaeaea")
            , borderRadius (px 5)
            , color inherit
            , cursor pointer
            , display inlineBlock
            , fontSize (pt 14)
            , height (px 40)
            , margin4 (px 5) (px 5) (px 5) (px 0)
            , minWidth (px 40)
            , padding4 (px 8) (px 13) (px 12) (px 13)
            , position relative
            , textAlign center
            , textShadow4 (px 0) (px 1) (px 2) (hex "888888")
            , verticalAlign baseline
            , withAttribute "disabled"
                [ cursor notAllowed
                , opacity (num 0.6)
                ]
            , let
                hoverStyles =
                    [ backgroundColor (hex "e8e8e8")
                    , borderColor (hex "888888")
                    , borderRadius (px 5)
                    , boxShadow4 zero (px 1) (px 3) (hex "cccccc")
                    ]
              in
              pseudoClass "not([disabled])"
                [ active hoverStyles
                , focus hoverStyles
                , hover hoverStyles
                ]
            ]
        , class (toClassName (Button IconButton))
            [ paddingLeft zero
            , paddingRight zero
            , width (px 40)
            ]
        , class (toClassName (Button LargeButton))
            [ height auto
            , padding2 (px 14) (px 18)
            ]
        , class (toClassName (Button PrimaryButton))
            [ backgroundImage (linearGradient (stop <| hex "95ff30") (stop <| hex "3be820") [])
            , borderColor transparent
            , color (hex "ffffff")
            , before
                [ borderRadius (px 5)
                , bottom zero
                , boxShadow5 inset zero (px -2) zero (rgba 0 0 0 0.2)

                -- , content " "
                , display block
                , position absolute
                , left zero
                , right zero
                , top zero
                ]
            , let
                hoverStyles =
                    [ backgroundColor (hex "c7e820")
                    , backgroundImage none
                    , borderColor transparent
                    , boxShadow none
                    ]
              in
              pseudoClass "not([disabled])"
                [ active hoverStyles
                , focus hoverStyles
                , hover hoverStyles
                ]
            ]
        , class (toClassName (Button SmallButton))
            [ height auto
            , padding4 (px 4) (px 8) (px 5) (px 8)
            ]
        , class (toClassName DetailPanel)
            [ backgroundColor (hex "fafafa")
            , borderRight3 (px 1) solid (hex "eeeeee")
            , displayFlex
            , flexDirection column
            , overflowY auto
            , width (px 300)
            ]
        , class (toClassName Layout)
            [ displayFlex
            , position relative
            ]
        , class (toClassName LayoutContent)
            [ flexGrow (num 1)
            ]
        , class (toClassName MainContent)
            [ displayFlex
            , height (calc (vh 100) minus (px 50))
            , overflow hidden
            ]
        , let
            hoverStyles =
                [ backgroundColor (hex "fafafa")
                ]
          in
          class (toClassName (MenuEntry Default))
            [ backgroundColor (hex "f5f5f5")
            , border zero
            , borderBottom3 (px 1) solid (hex "eeeee")
            , cursor pointer
            , displayFlex
            , lineHeight (px 50)
            , padding4 zero (px 20) zero zero
            , position relative
            , textAlign left
            , textOverflow ellipsis
            , whiteSpace noWrap
            , width (pct 100)
            , active hoverStyles
            , focus hoverStyles
            , hover hoverStyles
            ]
        , class (toClassName (MenuEntry Icon))
            [ flex (num 1)
            , minWidth (px 50)
            , textAlign center
            ]
        , class (toClassName (MenuEntry Label))
            [ flexGrow (num 1)
            , overflow hidden
            , textAlign left
            , textOverflow ellipsis
            , whiteSpace noWrap
            ]
        , class (toClassName PanelContent)
            [ flexGrow (num 1)
            , padding (px 10)
            , overflowY auto
            ]
        , class (toClassName (PanelMenu DefaultPanelMenu))
            [ backgroundImage (linearGradient2 (deg 30) (stop <| hex "f5f5f5") (stop <| hex "fcfcfc") [])
            , borderBottom3 (px 1) solid (hex "eeeeee")
            , displayFlex
            , flexDirection row
            , height (px 50)
            , lineHeight (px 50)
            , listStyle none
            , margin zero
            , padding4 zero zero zero (px 5)
            ]
        , class (toClassName (PanelMenu Menu))
            [ fontSize (pt 14)
            , lineHeight (px 50)
            , textAlign center
            , width (px 50)
            ]
        , class (toClassName (PanelMenu Spacing))
            [ flexGrow (num 1)
            ]
        , class (toClassName (PanelMenu Textfield))
            [ displayFlex
            , flexGrow (num 1)
            , marginRight (px 5)
            , padding2 (px 5) zero
            , descendants
                [ let
                    focusStyles =
                        [ backgroundColor (hex "ffffff")
                        ]
                  in
                  input
                    [ backgroundColor (hex "f0f0f0")
                    , flex (num 1)
                    , border zero
                    , borderRadius (px 5)
                    , padding (px 10)
                    , width (pct 100)
                    , active focusStyles
                    , focus focusStyles
                    ]
                ]
            ]
        , class (toClassName (PanelMenu Title))
            [ padding4 zero (px 10) zero (px 5)
            ]
        , class (toClassName PanelMenuFooter)
            [ paddingLeft (px 5)
            , paddingRight (px 5)
            ]
        , class (toClassName (Pill DefaultPill))
            [ backgroundColor (hex "eeeeee")
            , border3 (px 1) solid (hex "ffffff")
            , borderRadius (px 20)
            , boxShadow4 (px 0) (px 1) (px 2) (hex "aaaaaa")
            , display inlineBlock
            , height (px 20)
            , width (px 20)
            ]
        , class (toClassName (Pill InlinePill))
            [ backgroundColor (hex "eeeeee")
            , border3 (px 1) solid (hex "ffffff")
            , borderRadius (px 25)
            , boxShadow none
            , display inlineBlock
            , height (px 25)
            , lineHeight (px 20)
            , marginTop (px -5)
            , textAlign center
            , verticalAlign baseline
            , width (px 25)
            ]
        , class (toClassName (Pill PrimaryPill))
            [ backgroundColor (hex "95ff30")
            , color (hex "ffffff")
            ]
        , class (toClassName (Pill SupPill))
            [ display block
            , fontSize (pt 10)
            , lineHeight (px 12)
            , paddingTop (px 3)
            , position absolute
            , right (px -4)
            , top (px -4)
            ]
        , class (toClassName PanelMenuHeader)
            [ backgroundImage (linearGradient2 (deg 30) (stop <| hex "60b5cc") (stop <| hex "7fd13b") [])
            , borderBottom3 (px 2) solid (hex "60b5cc")
            ]
        , let
            hoverStyles =
                [ backgroundColor (hex "f5f5f5")
                ]
          in
          class (toClassName (StreamItem Default))
            [ backgroundColor transparent
            , border zero
            , borderBottom3 (px 1) solid (hex "eeeeee")
            , cursor pointer
            , displayFlex
            , lineHeight (px 50)
            , padding4 zero (px 20) zero zero
            , position relative
            , textAlign left
            , textOverflow ellipsis
            , whiteSpace noWrap
            , width (pct 100)
            , active hoverStyles
            , focus hoverStyles
            , hover hoverStyles
            ]
        , class (toClassName (StreamItem Icon))
            [ flexShrink (num 1)
            , minWidth (px 50)
            , textAlign center
            ]
        , class (toClassName (StreamItem Label))
            [ flexGrow (num 1)
            , overflow hidden
            , textAlign left
            , textOverflow ellipsis
            , whiteSpace noWrap
            ]
        , class (toClassName StreamItemHighlighted)
            [ fontWeight bold
            ]
        , class (toClassName StreamItemSub)
            [ backgroundColor (hex "fcfcfc")
            , before
                [ backgroundColor (hex "eeeeee")
                , bottom zero

                -- , content " "
                , display block
                , position absolute
                , left zero
                , top zero
                , width (px 5)
                ]
            ]
        , class (toClassName ThreadPanel)
            [ displayFlex
            , flexDirection column
            , flexGrow (num 1)
            ]
        , class (toClassName (ToolPanel DefaultToolPanel))
            [ backgroundColor (hex "f5f5f5")
            , borderRight3 (px 1) solid (hex "eeeeee")
            , displayFlex
            , flexDirection column
            , paddingLeft (px 5)
            , width (px 50)
            ]
        , class (toClassName (ToolPanel Item))
            [ borderBottom3 (px 1) solid (hex "f5f5f5")
            , displayFlex
            , flexDirection column
            , fontSize (pt 12)
            , lineHeight (px 50)
            ]
        , class (toClassName (ToolPanel Items))
            [ displayFlex
            , flexDirection column
            , flexGrow (num 1)
            , fontSize (px 0)
            , listStyle none
            , margin zero
            , padding zero
            , textOverflow ellipsis
            , whiteSpace noWrap
            ]
        , class (toClassName ToolPanelMenuFloating)
            [ backgroundColor (hex "ffffff")
            , boxShadow4 (px 2) (px 0) (px 3) (hex "cccccc")
            , height (pct 100)
            , left (px 50)
            , position absolute
            , zIndex (int 2)
            ]
        , class (toClassName ToolPanelMenu)
            [ borderRight3 (px 1) solid (hex "eeeeee")
            , displayFlex
            , flexDirection column
            , maxWidth (px 300)
            , minWidth (px 200)
            , overflowY auto
            ]
        ]
        |> Html.Styled.toUnstyled



-- BLOCKS


button : List ButtonModifier -> List (Attribute msg) -> List (Html msg) -> Html msg
button modifiers =
    bemWithModifiers Button modifiers Html.button


detailPanel : List (Attribute msg) -> List (Html msg) -> Html msg
detailPanel attrs children =
    bem DetailPanel Html.div attrs ([ globalStyles ] ++ children)


layout : List (Attribute msg) -> List (Html msg) -> Html msg
layout attrs children =
    bem Layout Html.div attrs ([ globalStyles ] ++ children)


layoutContent : List (Attribute msg) -> List (Html msg) -> Html msg
layoutContent =
    bem LayoutContent Html.div


mainContent : List (Attribute msg) -> List (Html msg) -> Html msg
mainContent =
    bem MainContent Html.section


menuEntry : List (Attribute msg) -> List (Html msg) -> Html msg
menuEntry =
    bem (MenuEntry Default) Html.button


menuEntryIcon : List (Attribute msg) -> List (Html msg) -> Html msg
menuEntryIcon =
    bem (MenuEntry Icon) Html.span


menuEntryLabel : List (Attribute msg) -> List (Html msg) -> Html msg
menuEntryLabel =
    bem (MenuEntry Label) Html.span


panelContent : List (Attribute msg) -> List (Html msg) -> Html msg
panelContent =
    bem PanelContent Html.div


panelMenu : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenu =
    bem (PanelMenu DefaultPanelMenu) Html.div


panelMenuHeader : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuHeader =
    bem PanelMenuHeader Html.ol


panelMenuFooter : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuFooter =
    bem PanelMenuFooter Html.ol


panelMenuMenu : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuMenu =
    bem (PanelMenu Menu) Html.li


panelMenuSpacing : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuSpacing =
    bem (PanelMenu Spacing) Html.li


panelMenuTextfield : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuTextfield =
    bem (PanelMenu Textfield) Html.li


panelMenuTitle : List (Attribute msg) -> List (Html msg) -> Html msg
panelMenuTitle =
    bem (PanelMenu Title) Html.li


pill : List PillModifier -> List (Attribute msg) -> List (Html msg) -> Html msg
pill modifiers =
    bemWithModifiers Pill modifiers Html.span


streamItem : List (Attribute msg) -> List (Html msg) -> Html msg
streamItem =
    bem (StreamItem Default) Html.button


streamItemIcon : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemIcon =
    bem (StreamItem Icon) Html.span


streamItemLabel : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemLabel =
    bem (StreamItem Label) Html.span


streamItemHighlighted : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemHighlighted =
    bem StreamItemHighlighted Html.button


streamItemSub : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemSub =
    bem StreamItemSub Html.button


threadPanel : List (Attribute msg) -> List (Html msg) -> Html msg
threadPanel =
    bem ThreadPanel Html.div


toolPanel : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanel =
    bem (ToolPanel DefaultToolPanel) Html.div


toolPanelMenuFloating : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanelMenuFloating =
    bem ToolPanelMenuFloating Html.div


toolPanelItem : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanelItem =
    bem (ToolPanel Item) Html.li


toolPanelItems : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanelItems =
    bem (ToolPanel Items) Html.ol


toolPanelMenu : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanelMenu =
    bem ToolPanelMenu Html.div


toolPanelTools : List (Attribute msg) -> List (Html msg) -> Html msg
toolPanelTools =
    bem (ToolPanel Tools) Html.ol



-- HELPERS


bem : Block -> (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
bem block tag attrs =
    tag ([ Attr.class (toClassNames block |> String.join " ") ] ++ attrs)


bemWithModifiers : (a -> Block) -> List a -> (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
bemWithModifiers toBlock modifiers tag userAttrs =
    let
        modifierToAttr modifier =
            toClassNames (toBlock modifier) |> String.join " "

        attrs =
            modifiers
                |> List.map (modifierToAttr >> Attr.class)
    in
    tag (attrs ++ userAttrs)
