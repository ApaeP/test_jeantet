class MainForm < ApplicationRecord

  TREE = {

    a: {
      question: "Êtes-vous une personne concernée ?",
      precisions: "Intermédiaire contribuable concerné, entreprise associée, toute autre personne ou entité susceptible d'être concernée par le dispositif.",
      answers: { yes: :b, no: :end_b },
      final_answer: nil
    },
    b: {
      question: "Y a-t-il un \"Dispositif\" concerné ? À savoir un Dispositif concernant les impôts : sur les sociétés, sur le revenu, sur les successions ou le patrimoine ou les droits d'enregistrement."
      precisions: "Le Dispositif peut : être un accord ou, un montage ou un plan (définition très large) ou, être sur-mesure ou cemmercialisable ou avoir une force exécutoire.",
      answers: { yes: :c, no: :end_a },
      final_answer: nil
    },
    c: {
      question: "Le Dispositif concerne-t-il la France et un autre Etat ?",
      precisions: "",
      answers: { yes: :d, no: :end_a },
      final_answer: nil
    },
    d: {
      question: "Tous les participants au Dispositif sont-ils fiscalement domiciliés ou résidents en France ou y ont-ils leur siège ?",
      precisions: "",
      answers: { yes: :end, no: :e },
      final_answer: nil
    },
    e: {
      question: "Au moins un des participants au Dispositif est-il fiscalement domicilié ou résident (ou a-t-il son siège dans plusieurs Etats ou territoires simultanément ?",
      precisions: "",
      answers: { yes: :i, no: :f },
      final_answer: nil
    },
    f: {
      question: "Au moins un des participants au Dispositif exerce-t-il une activité dans un autre Etat ou territoire par l'intermédiaire d'un établissement stable situé dans cet Etat ou territoire?",
      precisions: "",
      answers: { yes: :g, no: :h },
      final_answer: nil
    },
    g: {
      question: "Le Dispositif constitue-t-il une partie ou la totalité de cet établissement stable ?",
      precisions: "",
      answers: { yes: :i, no: :h },
      final_answer: nil
    },
    h: {
      question: "Au moins un des participants au Dispositif exerce-t-il une activité dans un autre Etat ou territoire sans y être fiscalement domicilié ou résident ni disposer d'établissement stable dans cet Etat ou territoire ?",
      precisions: "",
      answers: { yes: :i, no: :end_b },
      final_answer: nil
    },
    i: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories A ?",
      precisions: "Le Dispositif est soit soumis à une clause de confidentialité (envers d'autres intérmédiaires ou des autorités fiscales), soit sous honoraires de résultats/garantie (corrélation à l'économie d'impôts générée), soit commercialisable (montage et documentation standardisée).",
      answers: { yes: :o, no: :j },
      final_answer: nil
    },
    j: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories B ?",
      precisions: "Le Dispositif porte sur le \"commerce de pertes\", la conversion d'un revenu en un autre moindrement taxé ou des transactions circulaires.",
      answers: { yes: :o, no: :k },
      final_answer: nil
    },
    k: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégorie C1 ?",
      precisions: "Le Dispositif porte sur la déduction de paiements transfrontières entre enrtreprises associées (quasi) sans taxation corrélative ou la déduction d'amortissements pour un même actif",
      answers: { yes: :o, no: :l },
      final_answer: nil
    },
    l: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories C2 ?",
      precisions: "Le Dispsitif porte sur un allègement multiple et tranfrontière de la double imposition ou un transfert d'actif d'une valeur transfrontière asymétrique.",
      answers: { yes: :q, no: :m },
      final_answer: nil
    },
    m: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories D ?",
      precisions: "Le Dispositif permet de contourner la NCD ou organise une chaîne de propriété artificielle à caractère transfrontière dissimulant l'identité des bénéficiaires effectifs.",
      answers: { yes: :q, no: :n },
      final_answer: nil
    },
    n: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories E ?",
      precisions: "Le Dispositif concerne des prix de transfert : utilisation de régimes de protection unilatéraux, transfert entre entreprises associées d'actifs incorporels difficiles à évaluer ou transferts de fonctions/risques/actifs au sein d'un groupe emportant une baisse significative du BAII.",
      answers: { yes: :q, no: :end_b },
      final_answer: nil
    },
    o: {
      question: "Le Dispositif permet-il notamment d'obtenir un remboursement d'impôt, un allègement ou une diminution d'impôt, une réduction de dette fiscale, un report d'imposition ou une absence/dispense d'imposition ?",
      precisions: "",
      answers: { yes: :p, no: :end_b },
      final_answer: nil
    },
    p: {
      question: "L'avantage fiscal que procure le Dispositif est-il l'un des objectifs principaux du Dispositif ?",
      precisions: "La détermination du caractère principal de fait de manière objective, par opposition à une analyse subjective qui prendrait en compte les motivations ou l'intention des participants : p. ex. le Dispositif n'aurait pas été élaboré de la même façon sans l'existence de cet avantage. - L'importance de l'avantage fiscal est notamment déterminée en fonction de la valeur de l'avantage fiscal obtenu par rapport à la valeur des autres avantages retirés du Dispositif.",
      answers: { yes: :q, no: :end_b },
      final_answer: nil
    },
    q: {
      question: "Une déclaration doit être faite. Vous êtes un intermédiaire concepteur ?",
      precisions: "Personne qu conçoit, commercialise ou organise un dispositif transfrontière devant faire l'objet d'une déclaration, le met à disposition aux fins de sa mise en oeuvre ou en gère la mise en oeuvre.",
      answers: { yes: :x, no: :r },
      final_answer: nil
    },
    r: {
      question: "Vous êtes un intermédiaire prestataire de services / sachant ?",
      precisions: "Personne qui, compte tenu des faits et circonstances pertinents et sur la base des informations​ disponibles ainsi que de l'expertise en la matière et de la compréhension qui sont nécessaires​ pour fournir de tels services, sait ou pourrait raisonnablement être censée savoir qu'elle s'est​ engagée à fournir, directement ou par l'intermédiaire d'autres personnes, une aide, une​ assistance ou des conseils concernant la conception, la commercialisation ou l'organisation d'un​ dispositif transfrontière devant faire l'objet d'une déclaration, ou concernant sa mise à​ disposition aux fins de mise en œuvre ou la gestion de sa mise en œuvre.",
      answers: { yes: :s, no: :end_c },
      final_answer: nil
    },
    s: {
      question: "Vous : êtes fiscalement domicilié ou résident ou avez votre siège en France (à l'exclusion de​ tout établissement stable), possèdez en France un établissement stable qui fournit les services​ concernant le dispositif transfrontière déclarable, êtes constitué en France ou êtes régi par le​ droit français, êtes enregistré en France auprès d’un ordre ou d’une association professionnelle​ en rapport avec des services juridiques, fiscaux ou de conseil ou vous bénéficiez d’une​ autorisation d’exercer en France délivrée par cet ordre ou association.",
      precisions: "",
      answers: { yes: :t, no: :end_c },
      final_answer: nil
    },
    t: {
      question: "Vous satisfaisez à la condition territoriale dans plusieurs Etats membres de l'Union européenne.",
      precisions: "",
      answers: { yes: :u, no: :x },
      final_answer: nil
    },
    u: {
      question: "Vous êtes fiscalement domicilié ou résident ou avez votre siège social en France.",
      precisions: "",
      answers: { yes: :x, no: :v },
      final_answer: nil
    },
    v: {
      question: "Vous êtes fiscalement domicilié ou résident ou avez votre siège social dans autre Etat mebre de l'Union européenne.",
      precisions: "",
      answers: { yes: :end_d, no: :w },
      final_answer: nil
    },
    w: {
      question: "Vous disposez d'un établissement stable dans l'Union européenne par l'intermédiaire duquel les services concernant le Dispositif déclarables sont rendus.",
      precisions: "",
      answers: { yes: :end_d, no: :end_f },
      final_answer: nil
    },
    x: {
      question: "La déclaration de ces informations a été souscrite par un autre​ intermédiaire en France ou dans un autre État membre de l’Union européenne, et vous​ pouvez prouver par tout moyen que ces mêmes informations ont déjà​ fait l’objet d’une déclaration en France ou dans un autre État membre​ ou que ces mêmes informations doivent être déclarées par un​ intermédiaire ou un contribuable concerné qui a reçu notification de​ son obligation déclarative, sous réserve que l’intermédiaire qui se​ prévaut de la dispense n’a pas reçu cette notification.",
      precisions: "",
      answers: { yes: :end_h, no: :y },
      final_answer: nil
    },
    y: {
      question: "Vous êtes soumis au secret professionnel (p. ex. avocat).",
      precisions: "",
      answers: { yes: :z, no: :end_e },
      final_answer: nil
    },
    z: {
      question: "Votre client vous autorise à déclarer.",
      precisions: "",
      answers: { yes: :end_g, no: :end_e },
      final_answer: nil
    },
    end_a: {
      conclusion: "Pas de sujet DAC-6."
    },
    end_b: {
      conclusion: "Pas de sujet DAC-6 - Recommandation forte de validation de cette exclusion auprès d'un professionnel."
    },
    end_c: {
      conclusion: "La déclaration incombe au contribuable s'il souhaite mettre le Dispositif en oeuvre (ou l'a initié)."
    },
    end_d: {
      conclusion: "Vous devez déclarer dans cet Etat membre."
    },
    end_e: {
      conclusion: "La déclaration incombe au contribuable s'il souhaite mettre le Dispositif en oeuvre (ou l'a initié). Vous devez notifier aux autres intermédiaires et au client leur obligation de déclaration du Dispositif"
    },
    end_f: {
      conclusion: "La déclaration doit être faite dans l'Etat membre dans lequel vous êtes enregistré auprès d'un ordre, d'une association professionnelle en rapport avec les services fournis."
    },
    end_g: {
      conclusion: "Vous devez souscrire en France la déclaration prévue à l'article 1649 AD du CGI."
    },
    end_h: {
      conclusion: "Vous êtes dispensé de déclarer."
    }
  } # TREE
end
































