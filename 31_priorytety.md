# Priorytety

Sprawdź priorytet warstwy meta-application

    bitbake-layers show-layers

Skopiuj receptę example do innej warstwy, np meta-security

    cd layers/
    cp -r meta-ifm/recipes-example/ meta-security/

Dodaj do każdej recepty string, który będzie pokazywał która się wywołuje. np SECURITY: i IFM

Odpal build - która wersja jest odpalona podczas budowania?

## Zadanie

Ustaw priorytety na te same - co stanie się wtedy? 




1. Higher Numbers Take Precedence

Layer priority is assigned as an integer. The higher the numeric value, the higher the priority.  

    If meta-custom has a priority of 10 and meta-bsp has a priority of 6, BitBake will choose the recipe from meta-custom if there is a name collision.

2. Priority Overrides Recipe Version (PV)

A common misconception is that BitBake always selects the highest version of a recipe. In reality, layer priority is the ultimate decider.

    If Layer A (Priority 10) contains example_1.0.bb and Layer B (Priority 5) contains example_2.0.bb, BitBake will select version 1.0 from Layer A.

    It will completely ignore the newer version in Layer B because Layer A has a higher priority. Even setting PREFERRED_VERSION will not bypass this rule if the higher priority layer masks it.  

3. Tie-Breaking via bblayers.conf

If two layers provide the exact same recipe and share the exact same layer priority, BitBake falls back on the order they are listed in your build/conf/bblayers.conf file.

    The layer listed later (lower down) in the BBLAYERS list will take precedence and override the earlier one.