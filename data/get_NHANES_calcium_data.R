library(RNHANES)
demo <- nhanes_load_data("DEMO_F", "2009-2010") %>%
  select(SEQN, cycle, gender = RIAGENDR, age = RIDAGEYR)
vitd <- nhanes_load_data("VID_F", "2009-2010") %>%
  select(SEQN, vit_d = LBXVIDMS)
ca <- nhanes_load_data("BIOPRO_F", "2009-2010") %>%
  select(SEQN, calcium = LBXSCA)

calcium <- demo %>%
  left_join(vitd) %>%
  left_join(ca) %>%
  mutate(gender = factor(gender, levels = 1:2, labels = c("male", "female"))) %>%
  na.omit() %>%
  # solo mayores de 25: para que sea más claro el ajuste de dos rectas con
  # distinta pendiente, y no haya problemas de no-linealidad,
  filter(age > 25)

rm(demo, vitd, ca)

save.image("calcium.RData")
