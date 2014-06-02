
TURBO = true

###
#
# George Boole Collection costants, will be migrated to db when platformized
#
###

# COMMON

PUBLISHER = "UCC Library, University College Cork"
MAIN_AGENCY_CODE="UCC-Li"
COUNTRY_CODE = "IE"
LANGUAGE = "English"

# CONCERNING

LONG_TITLE = "The Papers of George Boole, F.R.S. (1815-1864)"
NAME = "George Boole"
REFERENCE_CODE = "IE BL/QQ/GB"
TITLE = "George Boole Collection"
INCLUSIVE_DATES = "1832-1964"
CONTEXT = <<EOS
George Boole, first professor of Mathematics at Queens College Cork (later UCC) was born on the 2 Nov 1815 in Lincoln, England the eldest son of  John Boole and his wife MaryAnn  Joyce. He had 3 siblings Maryann (1818 –1887), Charles (1819 –1888) and William (1821 –1902).In 1855 he married Mary Ann Everest and they had 5 children, all daughters  Mary Ellen (b. 1856), Margaret (b. 1858), Alice (b. 1860, Lucy (b. 1862) and Ethel (b.1864).

Boole died prematurely in 1864 at his home in Ballintemple, Co. Cork aged only 49. He caught a severe chill from walking in the rain, which later turned into a lung infection, causing his death.

The papers preserved here were collected by Boole’s sister Maryann after his death, to provide the sourcework for a proposed biography by her. They were subsequently purchased at auction by UCC.
EOS
CONTENT_AND_STRUCTURE = <<EOS
The collection consists mainly of personal letters to and from Boole, the original order having been lost an artificial order was imposed by the Archivist during processing. Very few of Boole’s academic works are preserved here, however drafts of unpublished lectures dealing with such topics as astronomy, ancient mythology, education and one entitled "Are the Planets Inhabited?" are extant.
Boole’s letters home to his sister after his arrival in Ireland contain valuable social information on the Cork of the mid nineteenth century, where lavish banquets were given to the elite while crowds of beggars thronged the streets. In October 1849 he describes one encounter with Cork’s poor which "far exceeded in horror anything not only that I had ever before witnessed but that I had even read of." He was present in Cork for the great flood of 1850, and was trapped upstairs in his lodgings by the flood waters, while friends of his were forced to traverse the streets in a boat.
The insights Boole’s letters give into the world of 19th century academia can be amusing as well as informative, as when in a letter to his friend, Dr. John Bury, he inquires whether or not his wife should continue to wear stays (corsets) while ‘confined’. The constant financial worries evidenced throughout his letters reflect a system by which professors were paid according to the number of students who had enrolled in their classes.
A large section of the collection contains material relating to Boole’s wife, Mary Everest,(after whose uncle the world’s highest peak was named), and their five daughters. One daughter, Mary Ellen Hinton spent some years in Japan as a teacher at the close of the century. Her diary, which contains wonderful descriptions of the sights she saw and people she met, is preserved here. Another daughter, Ethel Lilian Voynich, was the author of the novel ‘The Gadfly’ which she wrote after an affair with the renowned secret agent, Sydney Reilly.
Boole had been appointed to the chair of mathematics at Queens College, Cork in 1849 and was to remain teaching there for the rest of his life, gaining a reputation as an outstanding and dedicated thinker.

In 1854 he published An investigation into the Laws of Thought, on Which are founded the Mathematical Theories of Logic and Probabilities. Boole approached logic in a new way reducing it to a simple algebra, incorporating logic into mathematics. He pointed out the analogy between algebraic symbols and those that represent logical forms. It began the algebra of logic called Boolean algebra which now finds application in computer construction, switching circuits etc.

Boole also worked on differential equations, the influential Treatise on Differential Equations appeared in 1859, the calculus of finite differences, Treatise on the Calculus of Finite Differences (1860), and general methods in probability. He published around 50 papers and was one of the first to investigate the basic properties of numbers, such as the distributive property, that underlie the subject of algebra.

Many honours were given to Boole as the genius in his work was recognised. He received honorary degrees from the universities of Dublin and Oxford and was elected a Fellow of the Royal Society (1857). 
Today Boole is best remembered as the originator of Boolean Logic - a fundamental step in today's computer revolution, and the basis for all modern computer software.

Boole’s achievements are all the more impressive when you consider he was entirely self taught. He received only the most basic schooling, but was imbued from his childhood  by his father with a love of mathematics. He never attended a University not gained a formal qualification in his chosen subject.
EOS
LEVEL_OF_DESCRIPTION = "item"
EXTENT = "3 hefty boxes"
CO_LANGUAGE = LANGUAGE
ACCESS = "Available by appointment with the Archives Service to holders of UCC Readers tickets."
WEBSITE = "http://booleweb.ucc.ie/index.php?pageID=264"

CREATOR = "Boole & Co."
REPOSITORY = "Boole Library, University College Cork"
REPOSITORY_CODE = "IE-BL/1"
NUMBER_OF_ELEMENTS = 377

# OLD_SKOOL_FINDING_AID

FA_TITLE_PROPER = "PAPERS OF GEORGE BOOLE – CONTENT AND STRUCTURE"
FA_COMPILER = "Carol Quinn, Archivist"
FA_PUBLISHER = PUBLISHER
FA_WHEN = "2006" # 1990 ?
FA_URL = "http://booleweb.ucc.ie/media/Archives/George_Boole_Descriptive_List.pdf"
FA_LANGUAGE = LANGUAGE

# DIGITAL_SURROGATE

NUMBER_OF_SCANS = 2495
UNDONE = []             # items with no scans
INCOMPLETE = []         # items partially scanned
ORPHANED = []           # scans without items
PATH_TO_SCANS = ["../facsimiles/boole-facsimiles/BOOLE-MASTER-STAMPED-JPEG-1-OF-2/", "../facsimiles/boole-facsimiles/BOOLE-MASTER-STAMPED-JPEG-2-OF-2/"]
PATH_TO_THUMBS = "../../../facsimiles/boole-facsimiles/thumbs/"
PATH_TO_PINT_SIZE = "../../../facsimiles/boole-facsimiles/pint-size/"

# ELECTRONIC_FINDING_AID

EFA_REFERENCE_CODE= "IE EA/QQ/GB"
EFA_AUDIENCE = "internal"

EFA_TITLE_PROPER = FA_TITLE_PROPER
EFA_COMPILER = "Anthony Durity, PhD Researcher"
EFA_PUBLISHER = PUBLISHER
EFA_WHEN = "Jan 2014"
EFA_URL = "http://boole-papers.electropoiesis.org/archival_finding_aid?type=ead"
EFA_LANGUAGE = LANGUAGE

# GB_COLLECTION

CONCERNING = {
    long_title: LONG_TITLE,
    name: NAME,
    reference_code: REFERENCE_CODE,
    title: TITLE,
    inclusive_dates: INCLUSIVE_DATES,
    context: CONTEXT,
    content_and_structure: CONTENT_AND_STRUCTURE,
    level_of_description: LEVEL_OF_DESCRIPTION,
    number_of_elements: NUMBER_OF_ELEMENTS,
    extent: EXTENT,
    language: CO_LANGUAGE,
    access: ACCESS,
    website: WEBSITE
}

OLD_SKOOL_FINDING_AID = {
    title_proper: FA_TITLE_PROPER,
    compiler: FA_COMPILER,
    publisher: FA_PUBLISHER,
    when: FA_WHEN,
    url: FA_URL,
    language: FA_LANGUAGE
}

DIGITAL_SURROGATE = {
    num_scans: NUMBER_OF_SCANS,
    undone: UNDONE,
    incomplete: INCOMPLETE,
    orphaned: ORPHANED,
    scans_folder: PATH_TO_SCANS,
    thumbs_folder: PATH_TO_THUMBS,
    pint_size_folder: PATH_TO_PINT_SIZE
}

ELECTRONIC_FINDING_AID = {
    title_proper: EFA_TITLE_PROPER,
    compiler: EFA_COMPILER,
    publisher: EFA_PUBLISHER,
    when: EFA_WHEN,
    url: EFA_URL,
    language: EFA_LANGUAGE
}

GB_COLLECTION = {
    concerning: CONCERNING,
    old_skool_finding_aid: OLD_SKOOL_FINDING_AID,
    digital_surrogate: DIGITAL_SURROGATE,
    electronic_finding_aid: ELECTRONIC_FINDING_AID
}
