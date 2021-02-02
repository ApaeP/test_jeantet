class MainForm < ApplicationRecord

  def next_step
    TREE[self.answers.split('_').last.to_sym]
  end

  def previous_step
    TREE[self.answers.split('_')[-3].to_sym]
  end

  def current_question
    self.answers.split('_').last.to_sym
  end

  def back_to_previous_question
    if current_question == :b
      puts "\n\n\n\n\nCURRENT QUESTION IS B\n\n\n\n\n"
      p self.answers
      self.answers = "a"
    else
      puts "\n\n\n\n\nCURRENT QUESTION IS #{current_question}\n\n\n\n\n"
      self.answers = self.answers.gsub(/_[^_]*_[^_]*_[^_]*\z/, '')
    end
    self.save
  end

  def answer(question, answer)
    if self.answers.nil?
      self.answers = answer
      print_info(self.answer)
    else
      if self.current_question != question
        # self.answers = self.answers.split('_')[0...-3].join('_') + "_#{ question.to_s }_#{ answer.to_s }_#{ TREE[question][:answers][answer] }"
        self.answers = self.answers[0..-self.answers.match(/#{question}(.*)/)[1].length - 2] << "_#{ question.to_s }_#{ answer.to_s }_#{ TREE[question][:answers][answer] }"
      else
        if TREE[question][:answers].nil?
          self.answers
        else
          self.answers << "_#{ question.to_s }_#{ answer.to_s }_#{ TREE[question][:answers][answer] }"
        end
      end
    end
    self.save
  end

# Si j'ai Object : a_yes_b_b_no_endA
# que je suis sur la page de results de endA
# que je fais retour sur la derniere question
# et que j'essaie de repondre a nouveau
# en cliquant sur yes je dois
 # supprimer la string apres le premier b
 # self.answers = self.answers[0..-self.answers.match(/#{interpolation de current_question}(.*)/)[1].length - 2]
#
  # The answers are constructed like this :
      # answers =
        # 1 - nil
        # 2 - a_yes_b (only a answered)(where a is the question answered, yes is the answer and b is the next question related to this answer)
        # 3 - a_yes_b_b_no_endA (a & b answered)
        # 4 - a_yes_b_b_yes_c_c_yes_d_d_yes_endA (a, b, c & d answered)

  TREE =
  {
    a: {
      question: "Êtes-vous une personne concernée ?",
      precisions: "Intermédiaire contribuable concerné, entreprise associée, toute autre personne ou entité susceptible d'être concernée par le dispositif.",
      answers: { yes: :b, no: :endB },
    },
    b: {
      question: "Y a-t-il un \"Dispositif\" concerné ? À savoir un Dispositif concernant les impôts : sur les sociétés, sur le revenu, sur les successions ou le patrimoine ou les droits d'enregistrement.",
      precisions: "Le Dispositif peut : être un accord ou, un montage ou un plan (définition très large) ou, être sur-mesure ou cemmercialisable ou avoir une force exécutoire.",
      answers: { yes: :c, no: :endA },
    },
    c: {
      question: "Le Dispositif concerne-t-il la France et un autre Etat ?",
      precisions: "",
      answers: { yes: :d, no: :endA },
    },
    d: {
      question: "Tous les participants au Dispositif sont-ils fiscalement domiciliés ou résidents en France ou y ont-ils leur siège ?",
      precisions: "",
      answers: { yes: :endA, no: :e },
    },
    e: {
      question: "Au moins un des participants au Dispositif est-il fiscalement domicilié ou résident (ou a-t-il son siège dans plusieurs Etats ou territoires simultanément ?",
      precisions: "",
      answers: { yes: :i, no: :f },
    },
    f: {
      question: "Au moins un des participants au Dispositif exerce-t-il une activité dans un autre Etat ou territoire par l'intermédiaire d'un établissement stable situé dans cet Etat ou territoire?",
      precisions: "",
      answers: { yes: :g, no: :h },
    },
    g: {
      question: "Le Dispositif constitue-t-il une partie ou la totalité de cet établissement stable ?",
      precisions: "",
      answers: { yes: :i, no: :h },
    },
    h: {
      question: "Au moins un des participants au Dispositif exerce-t-il une activité dans un autre Etat ou territoire sans y être fiscalement domicilié ou résident ni disposer d'établissement stable dans cet Etat ou territoire ?",
      precisions: "",
      answers: { yes: :i, no: :endB },
    },
    i: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories A ?",
      precisions: "Le Dispositif est soit soumis à une clause de confidentialité (envers d'autres intérmédiaires ou des autorités fiscales), soit sous honoraires de résultats/garantie (corrélation à l'économie d'impôts générée), soit commercialisable (montage et documentation standardisée).",
      answers: { yes: :o, no: :j },
    },
    j: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories B ?",
      precisions: "Le Dispositif porte sur le \"commerce de pertes\", la conversion d'un revenu en un autre moindrement taxé ou des transactions circulaires.",
      answers: { yes: :o, no: :k },
    },
    k: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégorie C1 ?",
      precisions: "Le Dispositif porte sur la déduction de paiements transfrontières entre enrtreprises associées (quasi) sans taxation corrélative ou la déduction d'amortissements pour un même actif",
      answers: { yes: :o, no: :l },
    },
    l: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories C2 ?",
      precisions: "Le Dispsitif porte sur un allègement multiple et tranfrontière de la double imposition ou un transfert d'actif d'une valeur transfrontière asymétrique.",
      answers: { yes: :q, no: :m },
    },
    m: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories D ?",
      precisions: "Le Dispositif permet de contourner la NCD ou organise une chaîne de propriété artificielle à caractère transfrontière dissimulant l'identité des bénéficiaires effectifs.",
      answers: { yes: :q, no: :n },
    },
    n: {
      question: "Le Dispositif présente-t-il un \"marqueur\" de catégories E ?",
      precisions: "Le Dispositif concerne des prix de transfert : utilisation de régimes de protection unilatéraux, transfert entre entreprises associées d'actifs incorporels difficiles à évaluer ou transferts de fonctions/risques/actifs au sein d'un groupe emportant une baisse significative du BAII.",
      answers: { yes: :q, no: :endB },
    },
    o: {
      question: "Le Dispositif permet-il notamment d'obtenir un remboursement d'impôt, un allègement ou une diminution d'impôt, une réduction de dette fiscale, un report d'imposition ou une absence/dispense d'imposition ?",
      precisions: "",
      answers: { yes: :p, no: :endB },
    },
    p: {
      question: "L'avantage fiscal que procure le Dispositif est-il l'un des objectifs principaux du Dispositif ?",
      precisions: "La détermination du caractère principal de fait de manière objective, par opposition à une analyse subjective qui prendrait en compte les motivations ou l'intention des participants : p. ex. le Dispositif n'aurait pas été élaboré de la même façon sans l'existence de cet avantage. - L'importance de l'avantage fiscal est notamment déterminée en fonction de la valeur de l'avantage fiscal obtenu par rapport à la valeur des autres avantages retirés du Dispositif.",
      answers: { yes: :q, no: :endB },
    },
    q: {
      question: "Une déclaration doit être faite. Vous êtes un intermédiaire concepteur ?",
      precisions: "Personne qu conçoit, commercialise ou organise un dispositif transfrontière devant faire l'objet d'une déclaration, le met à disposition aux fins de sa mise en oeuvre ou en gère la mise en oeuvre.",
      answers: { yes: :x, no: :r },
    },
    r: {
      question: "Vous êtes un intermédiaire prestataire de services / sachant ?",
      precisions: "Personne qui, compte tenu des faits et circonstances pertinents et sur la base des informations​ disponibles ainsi que de l'expertise en la matière et de la compréhension qui sont nécessaires​ pour fournir de tels services, sait ou pourrait raisonnablement être censée savoir qu'elle s'est​ engagée à fournir, directement ou par l'intermédiaire d'autres personnes, une aide, une​ assistance ou des conseils concernant la conception, la commercialisation ou l'organisation d'un​ dispositif transfrontière devant faire l'objet d'une déclaration, ou concernant sa mise à​ disposition aux fins de mise en œuvre ou la gestion de sa mise en œuvre.",
      answers: { yes: :s, no: :endC },
    },
    s: {
      question: "Vous : êtes fiscalement domicilié ou résident ou avez votre siège en France (à l'exclusion de​ tout établissement stable), possèdez en France un établissement stable qui fournit les services​ concernant le dispositif transfrontière déclarable, êtes constitué en France ou êtes régi par le​ droit français, êtes enregistré en France auprès d’un ordre ou d’une association professionnelle​ en rapport avec des services juridiques, fiscaux ou de conseil ou vous bénéficiez d’une​ autorisation d’exercer en France délivrée par cet ordre ou association.",
      precisions: "",
      answers: { yes: :t, no: :endC },
    },
    t: {
      question: "Vous satisfaisez à la condition territoriale dans plusieurs Etats membres de l'Union européenne.",
      precisions: "",
      answers: { yes: :u, no: :x },
    },
    u: {
      question: "Vous êtes fiscalement domicilié ou résident ou avez votre siège social en France.",
      precisions: "",
      answers: { yes: :x, no: :v },
    },
    v: {
      question: "Vous êtes fiscalement domicilié ou résident ou avez votre siège social dans autre Etat mebre de l'Union européenne.",
      precisions: "",
      answers: { yes: :endD, no: :w },
    },
    w: {
      question: "Vous disposez d'un établissement stable dans l'Union européenne par l'intermédiaire duquel les services concernant le Dispositif déclarables sont rendus.",
      precisions: "",
      answers: { yes: :endD, no: :endF },
    },
    x: {
      question: "La déclaration de ces informations a été souscrite par un autre​ intermédiaire en France ou dans un autre État membre de l’Union européenne, et vous​ pouvez prouver par tout moyen que ces mêmes informations ont déjà​ fait l’objet d’une déclaration en France ou dans un autre État membre​ ou que ces mêmes informations doivent être déclarées par un​ intermédiaire ou un contribuable concerné qui a reçu notification de​ son obligation déclarative, sous réserve que l’intermédiaire qui se​ prévaut de la dispense n’a pas reçu cette notification.",
      precisions: "",
      answers: { yes: :endH, no: :y },
    },
    y: {
      question: "Vous êtes soumis au secret professionnel (p. ex. avocat).",
      precisions: "",
      answers: { yes: :z, no: :endE },
    },
    z: {
      question: "Votre client vous autorise à déclarer.",
      precisions: "",
      answers: { yes: :endG, no: :endE },
    },
    endA: {
      conclusion: "Pas de sujet DAC-6."
    },
    endB: {
      conclusion: "Pas de sujet DAC-6 - Recommandation forte de validation de cette exclusion auprès d'un professionnel."
    },
    endC: {
      conclusion: "La déclaration incombe au contribuable s'il souhaite mettre le Dispositif en oeuvre (ou l'a initié)."
    },
    endD: {
      conclusion: "Vous devez déclarer dans cet Etat membre."
    },
    endE: {
      conclusion: "La déclaration incombe au contribuable s'il souhaite mettre le Dispositif en oeuvre (ou l'a initié). Vous devez notifier aux autres intermédiaires et au client leur obligation de déclaration du Dispositif"
    },
    endF: {
      conclusion: "La déclaration doit être faite dans l'Etat membre dans lequel vous êtes enregistré auprès d'un ordre, d'une association professionnelle en rapport avec les services fournis."
    },
    endG: {
      conclusion: "Vous devez souscrire en France la déclaration prévue à l'article 1649 AD du CGI."
    },
    endH: {
      conclusion: "Vous êtes dispensé de déclarer."
    }
  } # TREE
end


