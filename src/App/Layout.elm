module App.Layout exposing
    ( layout
    , layoutContent
    , mainContent
    , menuEntry
    , menuEntryIcon
    , menuEntryLabel
    , streamItem
    , streamItemIcon
    , streamItemLabel
    )

import Css exposing (..)
import Css.Global exposing (..)
import Html exposing (Attribute, Html)
import Html.Attributes as Attr
import Html.Styled


type Block
    = Layout
    | LayoutContent
    | MainContent
    | MenuEntry MenuEntryElement
    | StreamItem MenuEntryElement


type MenuEntryElement
    = Default
    | Icon
    | Label


toClassName : Block -> String
toClassName block =
    (case block of
        Layout ->
            "layout"

        LayoutContent ->
            "layout-content"

        MainContent ->
            "main-content"

        MenuEntry Default ->
            "menu-entry"

        MenuEntry Icon ->
            "menu-icon__icon"

        MenuEntry Label ->
            "menu-icon__label"

        StreamItem Default ->
            "stream-item"

        StreamItem Icon ->
            "stream-item__icon"

        StreamItem Label ->
            "stream-item__label"
    )
        |> (\it -> "ui-" ++ it)


globalStyles : Html msg
globalStyles =
    Css.Global.global
        [ class (toClassName Layout)
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
        , (\_ ->
            let
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
          )
            ()
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
        , (\_ ->
            let
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
          ) ()
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
        ]
        |> Html.Styled.toUnstyled



-- BLOCKS


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


streamItem : List (Attribute msg) -> List (Html msg) -> Html msg
streamItem =
    bem (StreamItem Default) Html.button


streamItemIcon : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemIcon =
    bem (StreamItem Icon) Html.span


streamItemLabel : List (Attribute msg) -> List (Html msg) -> Html msg
streamItemLabel =
    bem (StreamItem Label) Html.span



-- HELPERS


bem : Block -> (List (Attribute msg) -> List (Html msg) -> Html msg) -> List (Attribute msg) -> List (Html msg) -> Html msg
bem block tag attrs =
    tag ([ Attr.class (toClassName block) ] ++ attrs)
